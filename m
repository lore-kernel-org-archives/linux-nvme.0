From: james.smart@broadcom.com (James Smart)
Date: Tue, 9 Oct 2018 11:44:14 -0700
Subject: [PATCH 10/16] nvmet-fcloop: Suppress a compiler warning
In-Reply-To: <20181008212854.68310-11-bvanassche@acm.org>
References: <20181008212854.68310-1-bvanassche@acm.org>
 <20181008212854.68310-11-bvanassche@acm.org>
Message-ID: <dddcef9e-df5b-8695-7d05-2b4bc0d38799@broadcom.com>



On 10/8/2018 2:28 PM, Bart Van Assche wrote:
> Building with W=1 enables the compiler warning -Wimplicit-fallthrough=3. That
> option does not recognize the fall-through comment in the fcloop driver. Hence
> relax that compiler option. This patch avoids that the compiler reports the
> following warning when building with W=1:
>
> drivers/nvme/target/fcloop.c:647:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     if (op == NVMET_FCOP_READDATA)
>        ^
>
> Cc: James Smart <james.smart at broadcom.com>
> Signed-off-by: Bart Van Assche <bvanassche at acm.org>

Looks good.

Reviewed-by:? James Smart <james.smart at broadcom.com>
