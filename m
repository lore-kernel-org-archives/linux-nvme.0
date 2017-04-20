From: sbates@raithlin.com (Stephen  Bates)
Date: Thu, 20 Apr 2017 20:47:51 +0000
Subject: [PATCH v3 2/2] blk-mq: Add a polling specific stats function
In-Reply-To: <6617fde7-4866-4a2d-6cf5-dc8b2c678186@kernel.dk>
References: <1491567843-26190-1-git-send-email-sbates@raithlin.com>
 <1491567843-26190-3-git-send-email-sbates@raithlin.com>
 <20170420200706.GA24823@vader.DHCP.thefacebook.com>
 <c7543e20-8f3f-03c4-38a2-de185e066aa2@kernel.dk>
 <20170420202039.GB24823@vader.DHCP.thefacebook.com>
 <808e7f83-9f55-29cf-7472-c09daea665bd@kernel.dk>
 <0E9E52B3-977A-4159-83B3-758564FF67AD@raithlin.com>
 <6617fde7-4866-4a2d-6cf5-dc8b2c678186@kernel.dk>
Message-ID: <D356CC80-F509-4427-B999-641636131E8D@raithlin.com>


> I agree, it's fine as-is. We should queue it up for 4.12.

Great. I will get something based on Omar?s latest comments asap.

> > However right now I am stuck as I am seeing the kernel oops I reported
> > before in testing of my latest patchset [1]. I will try and find some
>> time to bisect that but it looks like it was introduced when the
> > support for mq schedulers was added (on or around bd166ef18).

> Just replied to that one, let me know if the suggestion works.

That suggestion worked. Do you want me to send a patch for it?

Stephen
