From: keith.busch@intel.com (Keith Busch)
Date: Mon, 12 Jun 2017 10:30:37 -0400
Subject: [PATCH 2/2] nvme-cli: show more fields for id-ctrl
In-Reply-To: <1496387899-26012-3-git-send-email-guanjunxiong@huawei.com>
References: <1496387899-26012-1-git-send-email-guanjunxiong@huawei.com>
 <1496387899-26012-3-git-send-email-guanjunxiong@huawei.com>
Message-ID: <20170612143037.GB23969@localhost.localdomain>

On Fri, Jun 02, 2017@03:18:19PM +0800, Guan Junxiong wrote:
> NVMe 1.3 inctrodues new fields such as EDSTT, DSTO, FWUG, HCTMA, MNTMT,
> MXTMT, SANICAP into the idenfity controller data structure. The id-ctrl
> command should print them or write them into json format. Note that
> although KAS field is included in the previous NVMe 1.2.1 spec, this
> patch also supports this field.

Applied.

For future patches, please add you're "Signed-off-by" for all patches.
