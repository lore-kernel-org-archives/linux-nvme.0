From: keith.busch@intel.com (Keith Busch)
Date: Thu, 26 Jan 2017 12:09:16 -0500
Subject: [PATCH 2/2] nvme: Use CNS as 8-bit field and avoid endianness
 conversion
In-Reply-To: <1485443848-29478-2-git-send-email-maxg@mellanox.com>
References: <1485443848-29478-1-git-send-email-maxg@mellanox.com>
 <1485443848-29478-2-git-send-email-maxg@mellanox.com>
Message-ID: <20170126170916.GB1048@localhost.localdomain>

On Thu, Jan 26, 2017@05:17:28PM +0200, Max Gurtovoy wrote:
> From: Parav Pandit <parav at mellanox.com>
> 
> This patch defines CNS field as 8-bit field and avoids cpu_to/from_le
> conversions.
> Also initialize nvme_command cns value explicitly to NVME_ID_CNS_NS
> for readability (don't rely on the fact that NVME_ID_CNS_NS = 0).
> 
> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
> Signed-off-by: Parav Pandit <parav at mellanox.com>

Reviewed-by: Keith Busch <keith.busch at intel.com>
