From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 9 Jul 2019 09:37:33 -0700
Subject: [PATCH v2 2/2] nvme-tcp: don't use sendpage for SLAB pages
In-Reply-To: <3206ec8102d4dae933f4638652e84349dcc50ee4.1562586804.git.mskorzhinskiy@solarflare.com>
References: <cover.1562586804.git.mskorzhinskiy@solarflare.com>
 <3206ec8102d4dae933f4638652e84349dcc50ee4.1562586804.git.mskorzhinskiy@solarflare.com>
Message-ID: <2b2b9f09-5a02-68c8-722d-5e361ce292ed@grimberg.me>

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
