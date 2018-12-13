From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 13 Dec 2018 08:44:21 -0800
Subject: [PATCH] nvme-ioctl: clear rae for discovery log pages
In-Reply-To: <20181212082926.GB29996@lst.de>
References: <20181207220530.30310-1-sagi@grimberg.me>
 <20181212082926.GB29996@lst.de>
Message-ID: <2ff27701-0122-f15e-a19b-a7932af65aee@grimberg.me>


>> The discovery controller should now be able to send
>> us discovery log change events so we need to clear the
>> rae bit for that.
> 
> Btw, I really think we need to clear the RAE bit in the kernel with
> a small whitelist for those AENs that we pass on to userspace so that
> we don't accidentally get the bit cleared.  What do you think?

Makes sense...
