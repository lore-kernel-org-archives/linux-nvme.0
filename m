From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 7 May 2019 12:27:35 +0300
Subject: [PATCH nvme-cli rfc 3/6] fabrics: allow user to retrieve
 discovery log from existing discovery controller
In-Reply-To: <20190223023257.21227-4-sagi@grimberg.me>
References: <20190223023257.21227-1-sagi@grimberg.me>
 <20190223023257.21227-4-sagi@grimberg.me>
Message-ID: <23690b95-27e7-78a1-26f7-442fa6d6287d@mellanox.com>


On 2/23/2019 4:32 AM, Sagi Grimberg wrote:
> Simply allow discover to receive the discovery device node name.
> Also centralize extraction of controller instance from the controller
> name to a common helper.
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   fabrics.c | 32 ++++++++++++++++++++++----------
>   1 file changed, 22 insertions(+), 10 deletions(-)
>
> diff --git a/fabrics.c b/fabrics.c

same here for adding example of the command line.


otherwise looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
