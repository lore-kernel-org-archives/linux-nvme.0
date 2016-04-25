From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 25 Apr 2016 01:24:08 -0700
Subject: [PATCH 0/2] Add Opal unlock support to NVMe.
In-Reply-To: <1461366732-31779-1-git-send-email-rafael.antognolli@intel.com>
References: <1461366732-31779-1-git-send-email-rafael.antognolli@intel.com>
Message-ID: <20160425082408.GA13629@infradead.org>

On Fri, Apr 22, 2016@04:12:10PM -0700, Rafael Antognolli wrote:
> This patch series implement a small set of the Opal protocol for self
> encrypting devices. It's implemented only what is needed for saving a password
> and unlocking a given "locking range". The password is saved on the driver and
> replayed back to the device on resume from suspend to RAM. It is specifically
> supporting the single user mode.
> 
> It is not planned to implement the full Opal protocol (at least not for now).

I think the OPAL code should be a generic library outside the NVMe
code so that we can use it for SATA and SAS as well, just with a little
glue code for the Security Send / Receive commands to wire it up to
NVMe.
