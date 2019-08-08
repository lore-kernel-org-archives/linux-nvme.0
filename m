From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 8 Aug 2019 16:52:05 -0700
Subject: [PATCH v4 0/4] nvme-pci: Support for Apple 201+ (T2 chip)
In-Reply-To: <20190807075122.6247-1-benh@kernel.crashing.org>
References: <20190807075122.6247-1-benh@kernel.crashing.org>
Message-ID: <ae14ef26-b4a5-1ef2-e2a9-581e813893fe@grimberg.me>


> This series combines the original series and an updated version of the
> shared tags patch, and is rebased on nvme-5.4.
> 
> This adds support for the controller found in recent Apple machines
> which is basically a SW emulated NVME controller in the T2 chip.
> 
> The original reverse engineering work was done by
> Paul Pawlowski <paul at mrarm.io>.

Thanks, pulled to nvme-5.4
