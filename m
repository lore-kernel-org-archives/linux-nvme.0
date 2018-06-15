From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 15 Jun 2018 02:35:31 -0700
Subject: [PATCH] nvme-cli: Implement printing the get Keep Alive Timer
 feature
In-Reply-To: <20180613203929.12777-1-revanth.rajashekar@intel.com>
References: <20180613203929.12777-1-revanth.rajashekar@intel.com>
Message-ID: <20180615093531.GC10928@infradead.org>

> +	case NVME_FEAT_KATO:
> +		printf("\tKeep Alive Timeout (KATO) in milliseconds: %u\n", result);
> +		break;

Again a line break would be nice.

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
