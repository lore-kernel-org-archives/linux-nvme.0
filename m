From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 15 Jun 2018 02:33:45 -0700
Subject: [PATCH] nvme-cli: Implement printing the get timestamp feature.
In-Reply-To: <20180613195352.11657-1-revanth.rajashekar@intel.com>
References: <20180613195352.11657-1-revanth.rajashekar@intel.com>
Message-ID: <20180615093345.GA10928@infradead.org>

> +static void show_timestamp(struct nvme_timestamp *ts)
> +{
> +	printf("\tThe timestamp is : %lu\n", int48_to_long(ts->timestamp));
> +	printf("\t%s\n", (ts->attr & 2) ? "The Timestamp field was initialized with a "\
> +			"Timestamp value using a Set Features command." : "The Timestamp field was initialized "\
> +			"to ?0? by a Controller Level Reset.");
> +	printf("\t%s\n", (ts->attr & 1) ? "The controller may have stopped counting during vendor specific "\
> +			"intervals after the Timestamp value was initialized" : "The controller counted time in milliseconds "\
> +			"continuously since the Timestamp value was initialized.");

Can you use if / else statements insteda of the ? : operators to make
this more redable?

Otherwise this looks fine to me.
