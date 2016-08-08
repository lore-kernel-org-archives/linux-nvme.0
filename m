From: hch@lst.de (Christoph Hellwig)
Date: Mon, 8 Aug 2016 15:31:50 +0200
Subject: [PATCH v2 nvme-cli 2/4] fabrics: stringify discover output.
In-Reply-To: <1470657480-5868-3-git-send-email-sagi@grimberg.me>
References: <1470657480-5868-1-git-send-email-sagi@grimberg.me>
 <1470657480-5868-3-git-send-email-sagi@grimberg.me>
Message-ID: <20160808133149.GA19826@lst.de>

>  
> +static const char *arg_str(const char * const *strings,
> +		size_t array_size, size_t idx)
> +{
> +		if (idx < array_size && strings[idx])
> +			return strings[idx];
> +		return "unrecognized";
> +}

The indentation of the function body looks b0rked.
