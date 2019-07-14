From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 14 Jul 2019 17:08:43 +0900
Subject: [PATCH v2 1/3] nvme-fabrics: allow discovery subsystems accept a
 kato
In-Reply-To: <20190712180211.26333-2-sagi@grimberg.me>
References: <20190712180211.26333-1-sagi@grimberg.me>
 <20190712180211.26333-2-sagi@grimberg.me>
Message-ID: <20190714080843.GB2993@minwoo-desktop>

On 19-07-12 11:02:09, Sagi Grimberg wrote:
> This modifies the behavior of discovery subsystems to accept
> a kato as a preparation to support discovery log change
> events. This also means that now every discovery controller
> will have a default kato value, and for non-persistent connections
> the host needs to pass in a zero kato value (keep_alive_tmo=0).
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

This looks good to me.

Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>

Thanks,
