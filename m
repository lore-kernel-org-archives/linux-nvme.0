Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6728CA0FF0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Sep 2025 14:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=/CXP5PchANxZqGp3Gssb1xnZMCk6ZZsq9Lr1RRv1yS0=; b=TN2AJ569//vzs/
	0ywJ0KCE2QXYXNUVM3afDVxaC26ydgvY5xS2JL3azmV8pxrYk45XLc+Pv7625kEiGQlKqwhZhBsd0
	dDlSxwhAJMU0SM0Hw+iSQN3hsxGqfYpwdD3BBhxVnKOpy/7WHbHEyqMaUzifqH0i+rU2k6o8r17QQ
	eDgjj3O6QRflOucw06/3F6uIns1ZYODyBrtbyF+YILSlSxxPI7AmVN8VewnttJEjx7h0w5hdIgkc8
	HQm9yrILTkAEtsxLTuel5hVz4uLr1oN5+fM6N/Sa9ZeejeuFsn7Y+6wHYKWYxx8+zBA+uk+d57e5X
	Cy9lQWZHUJuVbj4p4sQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut5wL-0000000CwJR-34ZP;
	Mon, 01 Sep 2025 14:55:25 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut2zF-0000000C68y-2d7I
	for linux-nvme@lists.infradead.org;
	Mon, 01 Sep 2025 11:46:15 +0000
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3cdfb1ff7aeso2096648f8f.2
        for <linux-nvme@lists.infradead.org>; Mon, 01 Sep 2025 04:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756727172; x=1757331972; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/CXP5PchANxZqGp3Gssb1xnZMCk6ZZsq9Lr1RRv1yS0=;
        b=uycNUHUg0r+Cz6dyfHP8AOgfJnss/0p5ZWPzo5lshjSvnGIPExcWEazgxLCrjzBrxN
         0ks6WEkiK+bYcIEa1V1dhBxgKa1pFqA9WlfgVqJCwl5Gt8BVxddUJxHT9XsK0/2VEuWX
         4d8dblwURKiGIEXB/VwzIdDxiP7ElavaReDEFXznKBvj8gs/VUrPQ2OghQTwDmHAy09V
         owpdNe+0Q+FMJXgsGOeQIIzbqbHagHeZeDBIYTo9W0z/4HUdl8dsEHF6191Bd2khfkKV
         M8Zkx7A6j+4GGt9dfO143T5+G0/3BN8bTOZTR4GHPl8wA3vO4hTsr+vPZjNMikPn0Ufw
         UJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756727172; x=1757331972;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/CXP5PchANxZqGp3Gssb1xnZMCk6ZZsq9Lr1RRv1yS0=;
        b=ZIP5wo75dUG0toXEjGREGArDuFCqOmw5TWVHEtzDtEx8VC5gC8/itMFFjwXYMmS7e5
         GxL+MKgDiguy9nVuJbfhqvYl+zPJodXQ9AeeW1pnrKF14YGmdI6+32nEshCTvxtbDaUB
         1XvqKBiDptcxpMahOc6Vnipf13GumcuYvTgrBaycXoOgHQxgds1C89SJZ0Szai0Moqh0
         eRYcxq+pOQDgmA7V4XTkNvct7mmCDrK/CN+M0U6n33h0WvtYt5eSRU0HRGg6An70IHKn
         zKH44itXvPGfb8mVJS8aC7fzdA0l/x5MXHXgNdHHtx8Mm1i6W6I7HrD+avScx3cqqPCM
         Qkdg==
X-Forwarded-Encrypted: i=1; AJvYcCUrc2mmwn3AFgS2JgkZ3XgP0kbiBzTDiZaF56evZQsHlPl89uPeC7nY89hlT34+9N4GBorOS0xVBuxU@lists.infradead.org
X-Gm-Message-State: AOJu0YzVxNxsr2iS7fh9g1qxH+tXIWdTkDEF8LczGBYFLZkfXhLVxYPc
	vLORt1yJ5xc6rV1TERCKtBXnh54OijdIBOapOBSQT9tWMqu8vKfKE4Pj2sHkcPiouAQ=
X-Gm-Gg: ASbGncteh+qZzm9baDVQGLl/oe/sKRjBQMsaqdEOnZZctETFO/WdilfvjPcPlFDaY/w
	ARqawB9E/ItjHOeKDslvV/0wADe2lf5KwH0PuO8giBvq3KMkrsaX9DHjCbQUtggSURKD0JhbnFL
	fz/dTAvYD4WfaTEMlc2ttGCD2z9vMJhFYgl4Tmq30oGI/TsWKzgto2H5Fo1W614/m6gOWr6hj2F
	DJN81V9uYPoCMzEfdgvr68wkefwFZPySxPXHM6FfxFrQusiG9M1Uk3mkvjoG03Nh1Bylg5p0yEa
	puqIeV51AxfqJQw6XRYca2RCUuH6hE3pG7pt5/1hTcih8HKotdRiiytbuchpMKlf9t2thd5dwbg
	O+J+1/Kt600xYQhrbNvu1UB+BOybTkS3k5qqwpA==
X-Google-Smtp-Source: AGHT+IHlqFyBokSnfRsgCUq7ALQSf4KtqVA34zcf/hmeCVs/UatcVoPMPEKEgVaN9VTTEzBEDFIuLA==
X-Received: by 2002:a05:6000:24c1:b0:3c8:95b0:945e with SMTP id ffacd0b85a97d-3d1e01d4c59mr5678053f8f.43.1756727171860;
        Mon, 01 Sep 2025 04:46:11 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf276d643dsm15226323f8f.26.2025.09.01.04.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 04:46:11 -0700 (PDT)
Date: Mon, 1 Sep 2025 14:46:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Daniel Wagner <wagi@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH v3 2/4] nvme-fc: reorganize ctrl ref-counting and cleanup
 code
Message-ID: <202508310442.lBWBZ5AC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829-nvme-fc-sync-v3-2-d69c87e63aee@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250901_044613_671478_7D6B2FC1 
X-CRM114-Status: GOOD (  10.79  )
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

Hi Daniel,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Wagner/nvme-fabrics-introduce-ref-counting-for-nvmf_ctrl_options/20250829-234513
base:   c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
patch link:    https://lore.kernel.org/r/20250829-nvme-fc-sync-v3-2-d69c87e63aee%40kernel.org
patch subject: [PATCH v3 2/4] nvme-fc: reorganize ctrl ref-counting and cleanup code
config: x86_64-randconfig-161-20250830 (https://download.01.org/0day-ci/archive/20250831/202508310442.lBWBZ5AC-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202508310442.lBWBZ5AC-lkp@intel.com/

New smatch warnings:
drivers/nvme/host/fc.c:1492 nvme_fc_match_disconn_ls() warn: iterator used outside loop: 'ctrl'

Old smatch warnings:
drivers/nvme/host/fc.c:3180 nvme_fc_delete_association() warn: mixing irqsave and irq

vim +/ctrl +1492 drivers/nvme/host/fc.c

14fd1e98afafc0 James Smart 2020-03-31  1465  static struct nvme_fc_ctrl *
14fd1e98afafc0 James Smart 2020-03-31  1466  nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
14fd1e98afafc0 James Smart 2020-03-31  1467  		      struct nvmefc_ls_rcv_op *lsop)
14fd1e98afafc0 James Smart 2020-03-31  1468  {
14fd1e98afafc0 James Smart 2020-03-31  1469  	struct fcnvme_ls_disconnect_assoc_rqst *rqst =
14fd1e98afafc0 James Smart 2020-03-31  1470  					&lsop->rqstbuf->rq_dis_assoc;
14fd1e98afafc0 James Smart 2020-03-31  1471  	struct nvme_fc_ctrl *ctrl, *ret = NULL;
14fd1e98afafc0 James Smart 2020-03-31  1472  	struct nvmefc_ls_rcv_op *oldls = NULL;
14fd1e98afafc0 James Smart 2020-03-31  1473  	u64 association_id = be64_to_cpu(rqst->associd.association_id);
14fd1e98afafc0 James Smart 2020-03-31  1474  	unsigned long flags;
14fd1e98afafc0 James Smart 2020-03-31  1475  
14fd1e98afafc0 James Smart 2020-03-31  1476  	spin_lock_irqsave(&rport->lock, flags);
14fd1e98afafc0 James Smart 2020-03-31  1477  
14fd1e98afafc0 James Smart 2020-03-31  1478  	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
14fd1e98afafc0 James Smart 2020-03-31  1479  		spin_lock(&ctrl->lock);
14fd1e98afafc0 James Smart 2020-03-31  1480  		if (association_id == ctrl->association_id) {
14fd1e98afafc0 James Smart 2020-03-31  1481  			oldls = ctrl->rcv_disconn;
14fd1e98afafc0 James Smart 2020-03-31  1482  			ctrl->rcv_disconn = lsop;
14fd1e98afafc0 James Smart 2020-03-31  1483  			ret = ctrl;

There should maybe be a break statement here?

14fd1e98afafc0 James Smart 2020-03-31  1484  		}
14fd1e98afafc0 James Smart 2020-03-31  1485  		spin_unlock(&ctrl->lock);
14fd1e98afafc0 James Smart 2020-03-31  1486  	}
14fd1e98afafc0 James Smart 2020-03-31  1487  
14fd1e98afafc0 James Smart 2020-03-31  1488  	spin_unlock_irqrestore(&rport->lock, flags);
14fd1e98afafc0 James Smart 2020-03-31  1489  
14fd1e98afafc0 James Smart 2020-03-31  1490  	/* transmit a response for anything that was pending */
14fd1e98afafc0 James Smart 2020-03-31  1491  	if (oldls) {
14fd1e98afafc0 James Smart 2020-03-31 @1492  		dev_info(rport->lport->dev,
14fd1e98afafc0 James Smart 2020-03-31  1493  			"NVME-FC{%d}: Multiple Disconnect Association "
14fd1e98afafc0 James Smart 2020-03-31  1494  			"LS's received\n", ctrl->cnum);

ctrl->cnum is always an invalid pointer on this line.  Another
option would be to print ret->cnum instead ctrl->nmum.

14fd1e98afafc0 James Smart 2020-03-31  1495  		/* overwrite good response with bogus failure */
14fd1e98afafc0 James Smart 2020-03-31  1496  		oldls->lsrsp->rsplen = nvme_fc_format_rjt(oldls->rspbuf,
14fd1e98afafc0 James Smart 2020-03-31  1497  						sizeof(*oldls->rspbuf),
14fd1e98afafc0 James Smart 2020-03-31  1498  						rqst->w0.ls_cmd,
14fd1e98afafc0 James Smart 2020-03-31  1499  						FCNVME_RJT_RC_UNAB,
14fd1e98afafc0 James Smart 2020-03-31  1500  						FCNVME_RJT_EXP_NONE, 0);
14fd1e98afafc0 James Smart 2020-03-31  1501  		nvme_fc_xmt_ls_rsp(oldls);
14fd1e98afafc0 James Smart 2020-03-31  1502  	}
14fd1e98afafc0 James Smart 2020-03-31  1503  
14fd1e98afafc0 James Smart 2020-03-31  1504  	return ret;
14fd1e98afafc0 James Smart 2020-03-31  1505  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


