From: Alex_Gagniuc@Dellteam.com (Alex_Gagniuc@Dellteam.com)
Date: Wed, 27 Feb 2019 18:07:49 +0000
Subject: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
References: <20190222010502.2434-1-jonathan.derrick@intel.com>
 <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
 <2b7d8f45d11c47e69f56ad1bc3324dd1@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wg_e5M0b5aJJf8V_UYaqX12YYA9MEg=gHNp6ALE5fK23w@mail.gmail.com>
 <cbe2ed1562a64609be6538f5816ec1b6@ausx13mps321.AMER.DELL.COM>
 <20190225155501.GI10237@localhost.localdomain>
 <b35ebf928ed743cca6649a191c76957b@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wgRdATtsBzo-LDkWn_sW-PJvq95SahZcsTxxDMPzLWxKA@mail.gmail.com>
 <940d608e1a044a54abcb9d65923951f3@ausx13mps317.AMER.DELL.COM>
 <20190227175119.GB19455@localhost.localdomain>
Message-ID: <3f79c82de9844fb6b2e9d31d044f98de@ausx13mps317.AMER.DELL.COM>

On 2/27/19 11:51 AM, Keith Busch wrote:
> I can't tell where you're going with this. It doesn't sound like you're
> talking about hotplug anymore, at least.

We're trying to fix an issue related to hotplug. However, the proposed 
fixes may have unintended consequences and side-effects. I want to make 
sure that we're aware of those potential problems.

Alex
