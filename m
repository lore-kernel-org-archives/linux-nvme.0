From: ckulkarnilinux@gmail.com (chaitany kulkarni)
Date: Thu, 3 May 2018 19:36:23 -0700
Subject: [PATCH 08/20] nvmet: configure file backed ns for sync IO
In-Reply-To: <20180424174102.GA30909@lst.de>
References: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
 <20180418190011.3973-9-chaitanya.kulkarni@wdc.com>
 <20180424174102.GA30909@lst.de>
Message-ID: <CAK0tqim6PON0p4WntQ_ZKxv9WJZ1OgVmU4sOm3XtmQ1GcY7h7g@mail.gmail.com>

You are right, we should not be forcing O_SYNC on the target side.

How about we rename the sync configfs parameter to buffer/cache/vwc?
(or any other preferable name).
We use buffer IO (NO O_* flags when for open and submitting IO) when
that parameter is set and use O_DIRECT when that parameter is not set.

Any thoughts?

On Tue, Apr 24, 2018@10:41 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Apr 18, 2018@02:59:59PM -0400, Chaitanya Kulkarni wrote:
>> This patch allows file backed namespaces to use newly
>> introduced configfs attribute sync, when sync is set
>> we open the file with O_SYNC and use the work queue
>> to execute the NVMe read/write commands.
>
> So this adds support for buffered I/O.  But why do you force
> O_SYNC on everyone who uses buffered I/O?
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
