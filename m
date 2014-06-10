From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 10 Jun 2014 17:33:33 -0400
Subject: [PATCH v7] NVMe: conversion to blk-mq
In-Reply-To: <alpine.LRH.2.03.1406101515430.4699@AMR>
References: <1402392038-5268-1-git-send-email-m@bjorling.me>
 <1402392038-5268-2-git-send-email-m@bjorling.me>
 <alpine.LRH.2.03.1406100945250.4699@AMR>
 <A52B97CC-6D77-468B-9A9B-A5888AE63580@fb.com>
 <alpine.LRH.2.03.1406101140490.4699@AMR> <5397636F.9050209@fb.com>
 <alpine.LRH.2.03.1406101458470.4699@AMR> <5397753B.2020009@fb.com>
 <alpine.LRH.2.03.1406101515430.4699@AMR>
Message-ID: <20140610213333.GA10055@linux.intel.com>

On Tue, Jun 10, 2014@03:21:18PM -0600, Keith Busch wrote:
> Yeah, nvme_setup_prps is probably the least readable code in this driver.
> Maybe some comments are in order here...
> 
> There are two rules for an SGL to be mappable to a PRP:
> 
> 1. Every element must have zero page offset, except the first.
> 
> 2. Every element must end on a page boundary, except the last.

Or to put it another way, NVMe PRPs only support I/Os that describe a
single range of virtual memory.
