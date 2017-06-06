From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 6 Jun 2017 21:26:09 +0300
Subject: [PATCH v5 1/9] scatterlist: add sg_zeroout_area() helper
In-Reply-To: <20170606143617.32143-2-jthumshirn@suse.de>
References: <20170606143617.32143-1-jthumshirn@suse.de>
 <20170606143617.32143-2-jthumshirn@suse.de>
Message-ID: <eef19233-47d6-9ea3-9f03-d846ce578ef7@grimberg.me>


> +	while ((offset < buflen) && sg_miter_next(&miter)) {
> +		unsigned int len;
> +
> +		len = min(miter.length, buflen - offset);
> +		memset(miter.addr, '\0', len);

Why '\0' and not 0?
