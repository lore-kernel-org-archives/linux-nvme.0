From: jonathan.derrick@intel.com (Jon Derrick)
Date: Thu, 29 Oct 2015 09:10:56 -0600
Subject: [PATCH] nvme: prepare support for Apple NVMe controller
In-Reply-To: <bd1f730603ee00205657774a362aab10@localhost>
References: <bd1f730603ee00205657774a362aab10@localhost>
Message-ID: <20151029151056.GA2580@localhost.localdomain>

> +#define readq lo_hi_readq
> +#define writeq lo_hi_writeq
> +

Good job figuring that one out. But this should be a quirk:
a) It will sacrifice some io cycles on other devices
b) It may get lost at some point in the name of performance

Christoph recently added a quirks mechanism where I think it would fit
