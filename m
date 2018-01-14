From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 14 Jan 2018 11:28:23 +0200
Subject: [PATCH] nvme-pci: calculate iod and avg_seg_size just before use
 them
In-Reply-To: <20180111154857.GA2602@localhost.localdomain>
References: <1515647379-1877-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180111154857.GA2602@localhost.localdomain>
Message-ID: <e2b12a6e-c54a-c17b-4749-287633298af6@grimberg.me>


>> The calculation of iod and avg_seg_size maybe meaningless if
>> nvme_pci_use_sgls returns before uses them. So calculate
>> just before use them.
> 
> The compiler will do the right thing here, but I see what you mean. I
> think Christoph has some SGL improvements coming, though, that will
> obviate this.

I think that if its not coming for 4.16, it should be easy enough to
take it in.

FWIW,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
