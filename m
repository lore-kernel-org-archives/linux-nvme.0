From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 20 Jul 2018 08:36:31 +0200
Subject: [PATCH 0/4] Rework NVMe abort handling
In-Reply-To: <8d1ad465-c6b2-b67d-39f5-c88d849a89dd@broadcom.com>
References: <20180719132838.15556-1-jthumshirn@suse.de>
 <20180719134203.GA15212@lst.de>
 <20180719141025.yveza2svhvc2r4lw@linux-x5ow.site>
 <20180719142355.GA18800@lst.de>
 <20180719143534.i36vo45lhz24xbrg@linux-x5ow.site>
 <20180719145005.GA21000@lst.de>
 <20180719145422.2tdrbwa34gheuam3@linux-x5ow.site>
 <8d1ad465-c6b2-b67d-39f5-c88d849a89dd@broadcom.com>
Message-ID: <20180720063631.tn4nh2njt43u27bi@linux-x5ow.site>

On Thu, Jul 19, 2018@08:04:09AM -0700, James Smart wrote:
> Which I'm going to say no on. I originally did the abort before the reset
> and it brought out some confusion in the reset code. Thus the existing flow
> which just resets the controller which has to be done after the abort
> anyway.

OK copied that.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
