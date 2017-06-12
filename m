From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 12 Jun 2017 09:17:56 -0600
Subject: [PATCH] nvme: TUR(Test unit Ready) broken for nvme drvices
In-Reply-To: <20170612152358.GD23969@localhost.localdomain>
References: <1496677172-22797-1-git-send-email-wenxiong@linux.vnet.ibm.com>
 <20170605174454.GA5432@infradead.org>
 <20170612152358.GD23969@localhost.localdomain>
Message-ID: <e450f0ca-1e8f-04ca-1f4b-5a29fdf2f3d3@kernel.dk>

On 06/12/2017 09:23 AM, Keith Busch wrote:
> On Mon, Jun 05, 2017@10:44:54AM -0700, Christoph Hellwig wrote:
>> Given how broken the emulation was we should simply remove it.
> 
> Agreed!

I'm fine with killing it as well. On the FB infrastructure side, one of
the first things I did wrt nvme was ensure that we don't rely on or use
the scsi emulation at all.

And honestly, if even TUR is broken...

-- 
Jens Axboe
