From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 9 Aug 2018 09:20:07 +0200
Subject: [PATCH nvme-cli 1/2] fabrics: write ctrl_loss_tmo to fabrics
 device on connect
In-Reply-To: <SN6PR04MB451057AAB783DEBD356F9EA386260@SN6PR04MB4510.namprd04.prod.outlook.com>
References: <20180808071032.5914-1-jthumshirn@suse.de>
 <20180808071032.5914-2-jthumshirn@suse.de>
 <SN6PR04MB451057AAB783DEBD356F9EA386260@SN6PR04MB4510.namprd04.prod.outlook.com>
Message-ID: <20180809072007.wmyjlm35kzoxomy2@linux-x5ow.site>

On Wed, Aug 08, 2018@04:15:23PM +0000, Chaitanya Kulkarni wrote:
> +?????? if (cfg.ctrl_loss_tmo) {
> +?????????????? len = sprintf(p, ",ctrl_loss_tmo=%s", cfg.ctrl_loss_tmo);
> +?????????????? if (len < 0)
> +?????????????????????? return -EINVAL;
> +?????????????? p+= len;
> [CK] We can add a space before "+=" above.

Good point, thanks Chaitanya.


-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
