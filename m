From: kbusch@kernel.org (Keith Busch)
Date: Tue, 30 Jul 2019 15:34:04 -0600
Subject: [PATCH] drivers/nvme: save/restore HMB on suspend/resume
In-Reply-To: <8c5bfc2cee134ed392b5aa933827ed4e@AUSX13MPS303.AMER.DELL.COM>
References: <362aad7f1cf547c2a73e1c4f564984db@AUSX13MPS303.AMER.DELL.COM>
 <20190730204829.GI13948@localhost.localdomain>
 <c90ac9850f944407b39e369dce2e1e72@AUSX13MPS303.AMER.DELL.COM>
 <20190730211044.GJ13948@localhost.localdomain>
 <8c5bfc2cee134ed392b5aa933827ed4e@AUSX13MPS303.AMER.DELL.COM>
Message-ID: <20190730213404.GA14402@localhost.localdomain>

On Tue, Jul 30, 2019@09:32:13PM +0000, Charles.Hyde@dellteam.com wrote:
> Without this change, I have observed 100% failure rate with LiteOn CL1
> devices.  I was informed yesterday the vendor is investigating a root
> cause of S0ix failures with their device, I have not heard anything
> further.  Like you, I would wish this patch is not needed, and maybe it
> will not be when the vendor finishes their failure analysis.

Okay, let's wait to hear root cause before considering work-arounds.
