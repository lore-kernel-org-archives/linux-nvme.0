From: hch@lst.de (Christoph Hellwig)
Date: Thu, 15 Nov 2018 12:40:17 +0100
Subject: [PATCH v3 4/4] nvme: disable fabrics SQ flow control when
 asked by the user
In-Reply-To: <20181114182534.28807-5-sagi@grimberg.me>
References: <20181114182534.28807-1-sagi@grimberg.me>
 <20181114182534.28807-5-sagi@grimberg.me>
Message-ID: <20181115114017.GB17319@lst.de>

> +	/* fabrics parameter, allowed regardless of the transport */
> +	allowed_opts |= NVMF_OPT_DISABLE_SQFLOW;

This should got into NVMF_ALLOWED_OPTS instead.
