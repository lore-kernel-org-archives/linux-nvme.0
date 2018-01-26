From: thomas.tai@oracle.com (Thomas Tai)
Date: Fri, 26 Jan 2018 14:44:16 -0500
Subject: [PATCH v2 0/1] nvme: Add fault injection feature
In-Reply-To: <20180126075425.GC2356@lst.de>
References: <1516825390-3324-1-git-send-email-thomas.tai@oracle.com>
 <20180126075425.GC2356@lst.de>
Message-ID: <8fc0541c-3753-590b-7581-6eb469fe573e@oracle.com>

On 2018-01-26 02:54 AM, Christoph Hellwig wrote:
> On Wed, Jan 24, 2018@03:23:09PM -0500, Thomas Tai wrote:
>> Linux's fault injection framework provides a systematic way to support
>> error injection via debugfs in the /sys/kernel/debug directory. This
>> patch uses the framework to add error injection to NVMe driver.
> 
> Care to expand on the use cases a bit more?  Especially on what this
> buys us vs block layer error injection?
> 
Hi Christoph,

Thank you for your questions. The reason for adding error injection to
NVMe is ensure we're exercising error handling specifically for nvme
code path. The block layer error injection happens at the block layer
while the nvme error injection happens in the driver layer.

Following is the simplified diagram for those who are interested, where
*** denote block layer error injection point.
+++ denote nvme error injection point.

  .------------------------------ [ submit IO ] ---.
  |  Block layer                       |           |
  |                                    |           |
  |            ***generic_make_request |           |
  |                                    |           |
  |                                    v           |
  |                                  .---.         |
  | [ Submission/Completion      ]   |   |         |
  | [ Staging (Merge, Reorder, ) ]   .---. Req que |
  | [ Fairness Scheduling        ]   |   |         |
  | [ IO Accounting              ]   .---.         |
  |                                  |   |         |
  |                                  '---'         |
  |                                    |           |
  '----------------------------------- | ----------'
                                       v
  .------------------------------------------------.
  | Block device specific driver                   |
  |                                                |
  |     +++nvme_end_request                        |
  '------------------------------------------------'
            ^                          |
            | Status/Completion        |
            | Interrupt                |
            |                          v
  .------------------------------------------------.
  |              Hardware device                   |
  '------------------------------------------------'

Thanks,
Thomas
