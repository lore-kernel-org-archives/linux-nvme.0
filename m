From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 7 May 2019 12:22:06 +0300
Subject: [PATCH nvme-cli rfc 2/6] fabrics: support persistent connections
 to a discovery controller
In-Reply-To: <20190223023257.21227-3-sagi@grimberg.me>
References: <20190223023257.21227-1-sagi@grimberg.me>
 <20190223023257.21227-3-sagi@grimberg.me>
Message-ID: <d2900700-b933-2726-2d2b-89877c61e074@mellanox.com>


On 2/23/2019 4:32 AM, Sagi Grimberg wrote:
> Simply don't destroy the discovery controller after getting the
> log pages. Note that persistent connection to a discovery subsystem
> require to pass in a non-zero kato value, so if not provided we
> simply use a default of 30 seconds kato.
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

same here for example of the command line.

otherwise looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
