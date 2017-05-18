From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 18 May 2017 16:10:32 +0200
Subject: [PATCH nvme-cli] fabrics: add option to override drivers queue
 depth also for connect-all command
In-Reply-To: <20170511174837.17936-1-jthumshirn@suse.de>
References: <20170511174837.17936-1-jthumshirn@suse.de>
Message-ID: <81baac81-c2e6-7912-a485-424f9d235fef@suse.de>

On 05/11/2017 07:48 PM, Johannes Thumshirn wrote:
> Currently it is not possible to override the fabrics drivers default
> queue depth with the nvme userspace utility's 'connect-all' command,
> but only when using the 'connect' command.
> 
> Add an option to override the drivers default queue depth for NVMe
> over fabrics with the 'connect-all' command as we did previouslt with the
> 'connect' command.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---

Keith, ping?


-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
