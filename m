From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 3 Jul 2018 12:04:44 +0300
Subject: [PATCH] Support inline_data_size port parameter
In-Reply-To: <20180702152948.9D0362B88F@smtp.opengridcomputing.com>
References: <20180702152948.9D0362B88F@smtp.opengridcomputing.com>
Message-ID: <d2032770-ad1c-04cf-8795-94fd587f1c9c@grimberg.me>


> @@ -493,6 +497,9 @@ class UIReferralNode(UINode):
>           'trtype': ('string', 'Transport Type (e.g. rdma or loop or fc)'),
>           'portid': ('number', 'Port identifier'),
>       }
> +    ui_desc_param = {
> +        'inline_data_size': ('string', 'Port inline data size in bytes'),
> +    }

Umm, should a referral node have this?

Also, would this work with kernels that don't have it yet?
