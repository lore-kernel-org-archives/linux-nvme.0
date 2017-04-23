From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 23 Apr 2017 18:16:54 +0300
Subject: [PATCH] nvme: change cq_vector to a bool and set to true after
 request_irq
In-Reply-To: <20170423074710.GB20750@lst.de>
References: <1492817055-33601-1-git-send-email-sandeep@purestorage.com>
 <20170423074710.GB20750@lst.de>
Message-ID: <1f823755-d0d3-7294-8cc5-8ec773a544b2@grimberg.me>

>> +	bool cq_vector;
>
> I think the field is badly misnamed now.  Something like a flags
> field with an NVME_PCI_Q_IS_ALIVE flag might be more suitable now?

Agree.
