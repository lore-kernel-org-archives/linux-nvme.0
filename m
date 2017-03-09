From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 9 Mar 2017 14:56:27 +0100
Subject: [PATCH rfc 03/10] nvme-pci: open-code polling logic in nvme_poll
In-Reply-To: <1489065402-14757-4-git-send-email-sagi@grimberg.me>
References: <1489065402-14757-1-git-send-email-sagi@grimberg.me>
 <1489065402-14757-4-git-send-email-sagi@grimberg.me>
Message-ID: <534565a7-4a8d-d125-49db-c8679f716466@suse.de>

On 03/09/2017 02:16 PM, Sagi Grimberg wrote:
> Given that the code is simple enough it seems better
> then passing a tag by reference for each call site.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---

Deja-vu again?
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
