From: axboe@fb.com (Jens Axboe)
Date: Fri, 2 Dec 2016 21:16:11 -0700
Subject: [PATCH v3] nvme/pci: Log PCI_STATUS when the controller dies
In-Reply-To: <c28126550f46f20aec1f069a4a8d10d802332dda.1480697884.git.luto@kernel.org>
References: <c28126550f46f20aec1f069a4a8d10d802332dda.1480697884.git.luto@kernel.org>
Message-ID: <71a856fc-8a23-2686-fcc4-5ac05252e515@fb.com>

On 12/02/2016 09:58 AM, Andy Lutomirski wrote:
> When debugging nvme controller crashes, it's nice to know whether
> the controller died cleanly so that the failure is just reflected in
> CSTS, it died and put an error in PCI_STATUS, or whether it died so
> badly that it stopped responding to PCI configuration space reads.
> 
> I've seen a failure that gives 0xffff in PCI_STATUS on a Samsung
> "SM951 NVMe SAMSUNG 256GB" with firmware "BXW75D0Q".

I have added this for 4.10. Note that I had to hand-apply, since your
patch did not apply to the 4.10 branch. Additionally, you had a white
space problem before the call to nvme_warn_reset() that I also fixed up.

-- 
Jens Axboe
