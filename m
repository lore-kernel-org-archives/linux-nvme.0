From: keith.busch@intel.com (Keith Busch)
Date: Wed, 29 Apr 2015 13:22:22 +0000 (UTC)
Subject: some questions about create I/O queues
In-Reply-To: <5540471F.5030606@huawei.com>
References: <1425382201-2556-1-git-send-email-sunad.s@samsung.com>
 <004301d060aa$99924070$ccb6c150$@samsung.com>
 <20150317125914.GB4003@linux.intel.com> <5540471F.5030606@huawei.com>
Message-ID: <alpine.LNX.2.00.1504291321260.15930@localhost.lm.intel.com>

On Tue, 28 Apr 2015, dingxiang wrote:
>   When I create I/O queues and not create from qid 1,for example, I create
>   from qid 3,then I insmod nvme driver, there will be some error information as below

How did you manage to create IO queues starting from QID 3 when the
driver wasn't loaded?
