From: kbusch@kernel.org (Keith Busch)
Date: Tue, 30 Jul 2019 13:19:34 -0600
Subject: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
In-Reply-To: <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com>
References: <2332799.izEFUvJP67@kreacher>
 <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <CAJZ5v0iDQ4=kTUgW94tKGt7oJzA_3uVU_M6HAMbNCRXwp_do8A@mail.gmail.com>
 <47415939.KV5G6iaeJG@kreacher>
 <20190730144134.GA12844@localhost.localdomain>
 <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM>
 <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com>
Message-ID: <20190730191934.GD13948@localhost.localdomain>

On Wed, Jul 31, 2019@02:50:01AM +0800, Kai-Heng Feng wrote:
> 
> Just did a quick test, this patch regress SK Hynix BC501, the SoC stays at
> PC3 once the patch is applied.

Okay, I'm afraid device/platform quirks may be required unless there are
any other ideas out there.

I'm not a big fan of adding more params to this driver. Those are
global to the module, so that couldn't really handle a platform with
two different devices that want different behavior.
