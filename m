From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 16 Jul 2018 13:27:56 +0300
Subject: [PATCH v1] nvmet: Don't use uuid_le type
In-Reply-To: <20180716095908.7690-1-andriy.shevchenko@linux.intel.com>
References: <20180716095908.7690-1-andriy.shevchenko@linux.intel.com>
Message-ID: <27beef69-2f59-94dd-f592-a051a2cefcbd@grimberg.me>


> -	memcpy(&id->nguid, &ns->nguid, sizeof(uuid_le));
> +	memcpy(&id->nguid, &ns->nguid, 16);

how about memcpy(&id->nguid, &ns->nguid, sizeof(ns->nguid));
