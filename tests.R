library(testthat)

source("~/Documents/github/minion_qc/MinionQC.R")
test_d = "~/Documents/github/minion_qc/testfiles/test1.txt"

d = load_summary(test_d, min.q=c(-Inf, 7))

test_that('Q cutoff in load_summary work', {
    expect_equal(as.numeric(table(d$Q_cutoff)), c(10, 5))   
})

test_that('Reads per hour works', {
    expect_equal(d$reads_per_hour, c(10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 5, 5, 5, 5, 5))   
})

test_that('Flowcell labelling works', {
    expect_equal(unique(d$flowcell), "testfiles")
})

test_that('Cumulative base counting works', {
    expect_equal(d$cumulative.bases, c(100, 190, 270, 340, 400, 450, 490, 520, 540, 550, 100, 190, 270, 340, 400))
})

test_that('Flowcell mapping works', {
    expect_equal(d$row, c(10, 12, 20,  1, 23, 31, 23, 16, 16, 10, 10, 12, 20,  1, 23))
})

test_that('bases.gt works', {
    expect_equal(bases.gt(d, 100), 200)
    expect_equal(bases.gt(d, 0), 950)
    expect_equal(bases.gt(d, 10), 950)
    expect_equal(bases.gt(d, 50), 850)
})

test_that('bases.gt works', {
    expect_equal(reads.gt(d, 100), 2)
    expect_equal(reads.gt(d, 0), 15)
})


s = summary.stats(d, Q_cutoff = "All reads")

test_that('summary function works', {
    expect_equal(s$total.gigabases, 5.5e-07)
    expect_equal(s$mean.length, 55)
    expect_equal(s$median.length, 55)
    expect_equal(s$max.length, 100)
    expect_equal(s$mean.q, 7.5)
    expect_equal(s$median.q, 7.5)
    expect_equal(s$reads$'>20kb', 0)
})

test_that('short run works', {

    test_d = "~/Documents/github/minion_qc/testfiles/short_run/"
    test_f = "~/Documents/github/minion_qc/testfiles/short_run/sequencing_summary.txt"
    d = single.flowcell(test_f, test_d, 8)

})

test_that('1D2 run works', {
    
    test_d = "~/Documents/github/minion_qc/testfiles/1D2/"
    test_f = "~/Documents/github/minion_qc/testfiles/1D2/sequencing_summary.txt"
    d = single.flowcell(test_f, test_d, 8)
    
})
