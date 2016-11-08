From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 8 Nov 2016 11:42:11 +0100
Subject: [PATCH RFC nvme-cli 2/2] nvme.spec: generate hostnqn file on
 install and remove on uninstall
In-Reply-To: <3e1f41d7-e518-da7d-b561-2e17ca622a8b@grimberg.me>
References: <1478459581-22654-1-git-send-email-sagi@grimberg.me>
 <1478459581-22654-3-git-send-email-sagi@grimberg.me>
 <20161107083639.naen6aolbogpe2ic@linux-x5ow.site>
 <3e1f41d7-e518-da7d-b561-2e17ca622a8b@grimberg.me>
Message-ID: <20161108104211.6pejnnt7uhbrg6ly@linux-x5ow.site>

On Tue, Nov 08, 2016@12:31:07PM +0200, Sagi Grimberg wrote:
> 
> > Two things, a) are you sure this is correct? I interpret $year_month as year
> > and month, not year and day (date | awk '{print $6"-"$3}' evaluates to 2016-7
> > here) and b) 'date +"%Y-%m"' saves you a 2nd process.
> 
> Thanks for the tip... I'm moving it to nvme utility though.

Yes that's probably better.

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
