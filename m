From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Fri, 22 Jul 2016 18:32:23 -0700
Subject: [PATCH] add u64 number parser
In-Reply-To: <5792b919.0C1gyf+dF4XKu6Zj%james.smart@broadcom.com>
References: <5792b919.0C1gyf+dF4XKu6Zj%james.smart@broadcom.com>
Message-ID: <5e325cbb-a140-8f26-7402-5dc1a2cd07ea@sandisk.com>

On 07/22/16 17:23, James Smart wrote:
> +	buf = kmalloc(len + 1, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +	memcpy(buf, s->from, len);
> +	buf[len] = '\0';

Hello James,

Have you considered to combine the above kmalloc() and memcpy() calls 
into a single kasprintf(GFP_KERNEL, "%.*s", len, s->from) call?

Bart.
