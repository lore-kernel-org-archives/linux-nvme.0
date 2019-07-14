From: james.smart@broadcom.com (James Smart)
Date: Sun, 14 Jul 2019 08:00:07 -0700
Subject: [PATCH v2 1/3] nvme-fabrics: allow discovery subsystems accept a
 kato
In-Reply-To: <20190712180211.26333-2-sagi@grimberg.me>
References: <20190712180211.26333-1-sagi@grimberg.me>
 <20190712180211.26333-2-sagi@grimberg.me>
Message-ID: <81232ff3-15e5-5583-0459-8d044b581c47@broadcom.com>



On 7/12/2019 11:02 AM, Sagi Grimberg wrote:
> This modifies the behavior of discovery subsystems to accept
> a kato as a preparation to support discovery log change
> events. This also means that now every discovery controller
> will have a default kato value, and for non-persistent connections
> the host needs to pass in a zero kato value (keep_alive_tmo=0).
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/fabrics.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
>
>

Reviewed-by: James Smart <james.smart at broadcom.com>
