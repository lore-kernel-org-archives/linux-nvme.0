From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 30 May 2017 11:48:09 +0200
Subject: [PATCH 2/7] nvmet: add uuid field to nvme_ns and populate via
 configfs
In-Reply-To: <20170530092442.GA16736@lst.de>
References: <cover.1496131397.git.jthumshirn@suse.de>
 <4aecbc794651073b2812341dc63e1f2918cc6a82.1496131397.git.jthumshirn@suse.de>
 <20170530092442.GA16736@lst.de>
Message-ID: <c5537393-445d-73f8-f8e0-cc9c51d3edcb@suse.de>

On 05/30/2017 11:24 AM, Christoph Hellwig wrote:
> This should be stored as a uuid_t (or rather uuid_be in the current
> kernel, but I'm about to rename it), and use uuid_be_to_bin / uuid_to_bin
> for parsing.

OK, thought you ask me to do that. Which one do you prefer?

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
