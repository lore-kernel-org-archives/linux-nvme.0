Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF73D5E124
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 03:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0vTwcqlNTxpupUm8LuR+47+qzjLW9Pak4HPOTiUsuuM=; b=GS63I8lHEY0ic0dprgfzI+M0lF
	pwBlsUzw3pt91SpSWotNNWnF4gUSZEZFERQ/5LKDQ67lSwerCXo67QsB24N9hOGSqi8GxJZfkpfrY
	gbK2/5d7mTuRwW/awbwJvWXmt+i+Bfr2Fm4PgFpvzldJlsLul6Z4PNGv9VYPJU6HOUpvIwl8mgmFs
	f83Kg0N2GWsqYqIFf5p3vEmXpFYB2tNNpVisPlhsVUv/MtnBsrGNz9vGM8i1YZ2nO9AbRvS9l1ad4
	05K1VOXbzfU9gpVpO10j8zo1XAt2R9N+W9iQFIcy3ZpTlPjpGe5/Gxj0/H2xj+FkpQNDhoxd8nU+n
	Uia5bBwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Fgz-000000098UZ-2pFs;
	Fri, 08 Nov 2024 03:29:49 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Fgu-000000098Tv-2mkj
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 03:29:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731036580; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0vTwcqlNTxpupUm8LuR+47+qzjLW9Pak4HPOTiUsuuM=;
	b=Vf1CroMRH0eZ3SVr39fO5zc0a3BaTvQbRUJMWZq4Z0m0GwB/QsL2bNmMjMzW8bDO7PM7rqOggKJcAYOGm2fLtcHIivv6aLrSZqn/8o2pcS97mRwK+5TphHI9ALLM4Mh10SMUpWw6XZ9Av5T4y0JBjsquAKy3oqYTER09AFKVzRs=
Received: from 30.178.81.252(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIxQktM_1731036575 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 Nov 2024 11:29:37 +0800
Message-ID: <c44c4ea6-ef4d-4152-ba21-9a76011dd75e@linux.alibaba.com>
Date: Fri, 8 Nov 2024 11:29:35 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [linux-nvme:nvme-6.13 7/7] drivers/nvme/target/pr.c:857:34:
 sparse: sparse: incorrect type in assignment (different base types)
To: kernel test robot <lkp@intel.com>, Keith Busch <kbusch@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Dmitry Bogdanov <d.bogdanov@yadro.com>,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
References: <202411081109.soCWJfGT-lkp@intel.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <202411081109.soCWJfGT-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_192946_047427_FDBBBDB9 
X-CRM114-Status: GOOD (  12.07  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


在 2024/11/8 11:18, kernel test robot 写道:
> tree:   git://git.infradead.org/nvme.git nvme-6.13
> head:   4c0ce9416cd06e9ef0e049f7a9226707c3786b1a
> commit: 4c0ce9416cd06e9ef0e049f7a9226707c3786b1a [7/7] nvmet: support reservation feature
> config: x86_64-randconfig-121-20241108 (https://download.01.org/0day-ci/archive/20241108/202411081109.soCWJfGT-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241108/202411081109.soCWJfGT-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202411081109.soCWJfGT-lkp@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
>>> drivers/nvme/target/pr.c:857:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] cntlid @@     got int @@
>     drivers/nvme/target/pr.c:857:34: sparse:     expected restricted __le16 [usertype] cntlid
>     drivers/nvme/target/pr.c:857:34: sparse:     got int
>
> vim +857 drivers/nvme/target/pr.c
>
>     802	
>     803	static void nvmet_execute_pr_report(struct nvmet_req *req)
>     804	{
>     805		u32 cdw11 = le32_to_cpu(req->cmd->common.cdw11);
>     806		u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
>     807		u32 num_bytes = 4 * (cdw10 + 1); /* cdw10 is number of dwords */
>     808		u8 eds = cdw11 & 1; /* Extended data structure, bit 00 */
>     809		struct nvme_registered_ctrl_ext *ctrl_eds;
>     810		struct nvme_reservation_status_ext *data;
>     811		struct nvmet_pr *pr = &req->ns->pr;
>     812		struct nvmet_pr_registrant *holder;
>     813		struct nvmet_pr_registrant *reg;
>     814		u16 num_ctrls = 0;
>     815		u16 status;
>     816		u8 rtype;
>     817	
>     818		/* nvmet hostid(uuid_t) is 128 bit. */
>     819		if (!eds) {
>     820			req->error_loc = offsetof(struct nvme_common_command, cdw11);
>     821			status = NVME_SC_HOST_ID_INCONSIST | NVME_STATUS_DNR;
>     822			goto out;
>     823		}
>     824	
>     825		if (num_bytes < sizeof(struct nvme_reservation_status_ext)) {
>     826			req->error_loc = offsetof(struct nvme_common_command, cdw10);
>     827			status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
>     828			goto out;
>     829		}
>     830	
>     831		data = kmalloc(num_bytes, GFP_KERNEL);
>     832		if (!data) {
>     833			status = NVME_SC_INTERNAL;
>     834			goto out;
>     835		}
>     836		memset(data, 0, num_bytes);
>     837		data->gen = cpu_to_le32(atomic_read(&pr->generation));
>     838		data->ptpls = 0;
>     839		ctrl_eds = data->regctl_eds;
>     840	
>     841		rcu_read_lock();
>     842		holder = rcu_dereference(pr->holder);
>     843		rtype = holder ? holder->rtype : 0;
>     844		data->rtype = rtype;
>     845	
>     846		list_for_each_entry_rcu(reg, &pr->registrant_list, entry) {
>     847			num_ctrls++;
>     848			/*
>     849			 * continue to get the number of all registrans.
>     850			 */
>     851			if ((void *)(ctrl_eds + sizeof(*ctrl_eds)) >
>     852				(void *)(data + num_bytes))
>     853				continue;
>     854			/*
>     855			 * Dynamic controller, set cntlid to 0xffff.
>     856			 */
>   > 857			ctrl_eds->cntlid = NVME_CNTLID_DYNAMIC;

Hi Keith,

     I miss here should use cpu_to_le16, should I send a v20 to fix this?

Best Regards,

Guixin Liu

>     858			if (rtype == NVME_PR_WRITE_EXCLUSIVE_ALL_REGS ||
>     859			    rtype == NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS)
>     860				ctrl_eds->rcsts = 1;
>     861			if (reg == holder)
>     862				ctrl_eds->rcsts = 1;
>     863			uuid_copy((uuid_t *)&ctrl_eds->hostid, &reg->hostid);
>     864			ctrl_eds->rkey = cpu_to_le64(reg->rkey);
>     865			ctrl_eds++;
>     866		}
>     867		rcu_read_unlock();
>     868	
>     869		put_unaligned_le16(num_ctrls, data->regctl);
>     870		status = nvmet_copy_to_sgl(req, 0, data, num_bytes);
>     871		kfree(data);
>     872	out:
>     873		nvmet_req_complete(req, status);
>     874	}
>     875	
>

