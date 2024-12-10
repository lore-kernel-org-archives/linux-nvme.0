Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87497E77180
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 08:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=jblJqgnONYB3Ttb04kcM1REB0r64XNYjHV8iVLuGuGg=; b=2n+JEmyXpRpjub
	kNOvmyRViBi39JGq1eUqcNfa1ICnmwi5XccISH2eHEBevZ218MrSk5ZwqGK6A1o31ZRxskYPbvycY
	QJPj9q4naBdxk9pKk//zvzWPD2f8jVgrSnxaTblIVsvpG7MGf/Nr6kUc1VkUU9dbnvzFBVmnD7foQ
	2Aiz5/laxV4okEVzmGPV/tBrxXb77tgVa1ojn6uES6Q7BJ2qNFiNirKY/oJOafo3dbtJ8bZLTxeL0
	BcSzyin7Jj2tYsjr0F2OrcOhLMZ94eCqEDzaT0+U0RbJ51uvfc7ZVTj+mHHrBW0sruro/B66oQ30U
	0T2kUpPyv3saRnK6pNRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKvtF-0000000AlXr-258D;
	Tue, 10 Dec 2024 08:46:45 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKvsK-0000000AlCk-27hI
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 08:45:49 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-432d86a3085so34732925e9.2
        for <linux-nvme@lists.infradead.org>; Tue, 10 Dec 2024 00:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733820347; x=1734425147; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jblJqgnONYB3Ttb04kcM1REB0r64XNYjHV8iVLuGuGg=;
        b=YB4D7WqctKosrBQiuLhYYsLfT/9+6V0LwDzJDy2/a+RZ+Fet94lALBjq74fmWcMIUU
         TQZP26/d63w09G11gikdnFa29ix9t8gFZgjn0XhYTkB08nwQrweC9kKWSelp5Lz8cF1g
         kAWqAbE4YnU85TYrj7MeCC1eIYKqFR3oqOjfrKV84cUmJz30DHWcUJ/fU2DwQwhZFiM8
         7SwWTaTSKcFL5j9yF5wP+JhZctKYyBdSSnw6De3QywmOkBGI4fOm+J6G2vENZSWrGbia
         SXe72piklm8WU4+Fhv8PMEnKAZvcsXCbwwhWskUpFnSzWmmbQrf28vsKB7DjRSm1ghnc
         7vMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733820347; x=1734425147;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jblJqgnONYB3Ttb04kcM1REB0r64XNYjHV8iVLuGuGg=;
        b=TpDse/DHoP4qm0ja75WdLhE/9ZAlhRl5AJ+tzMlCF2TO2bqx88qeZcY4kgG8hytPCp
         qfo7eZCyNA6QUet9P+9tkn5+Bchkos8UnaRgdUAl/Ys2Esszr+QYHYL+8lmUR/12gM59
         pthW/tKaPi/SCBoGNp06GanYoMB1wIZfEsA+59TtzFVr7Nnfl7+fSv2Vh0r8LMnTxHAD
         zfo4Akj7uLcvg0j7+Z484NePIorr8SeCuDySItiNjQEUGL1PJ9BGVMUJW+yDM2Wf5wxb
         4KZvfPLos6/FE75Blfs6ifOZtKZHdMjtuxwr7Q+rec3JDK6RSJCeJ7q/IAV7vZ+WEhN8
         h54w==
X-Forwarded-Encrypted: i=1; AJvYcCXsKvdiWS5UT3x7d/QlD//1aQdlg7g8eIVynhnXxLF+5qQeoMX9qseYERgmwhtKRW55BF65L13WOmpn@lists.infradead.org
X-Gm-Message-State: AOJu0YwGdwHlfMe1xRslU+7aiwIuRpB9kA75HjfeUSJW+b8TTxfXHk6m
	f8gptwHULFm/mwdg6/lE68MdZ0paNaUfpI/vLwYjq8GR51joZ9gKVqMluNvxDX4=
X-Gm-Gg: ASbGncuKI+PsHke1TFxOt0OjMshcVBPKdDaiW1UlVGELsE4tnwUuH4pnnLufTUJqRGh
	sSLKK43nQGifTWQyabi4qAyQMR6SUEcch0TkB406Qm31OnBgmNA2wgGQE04wfFNwFEDX+vWyt6s
	2hyXDt4aqNr9OQsCTzRoRlbD4mGAbr1H/0OJnVQLDPVgcUpNCbKZWSZK0gBB5i1m8oASQ9Ej15/
	guFogU2g0cx+e9GAg4acDqusRiMGm9798HXKW/mck7g3JBp8bNMWGtM05E=
X-Google-Smtp-Source: AGHT+IHBg7FH0RfI63+Vg3g5RF/j5aX39c5DAnNY2YHqX7RE5+k+C41N38XjDYzZeGnDTOmqptoH7w==
X-Received: by 2002:a05:600c:4e8a:b0:434:ffd7:6fca with SMTP id 5b1f17b1804b1-434fff36e7cmr31129635e9.2.1733820346746;
        Tue, 10 Dec 2024 00:45:46 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d526b577sm224504225e9.3.2024.12.10.00.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 00:45:46 -0800 (PST)
Date: Tue, 10 Dec 2024 11:45:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Keith Busch <kbusch@meta.com>,
	axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, sagi@grimberg.me,
	asml.silence@gmail.com, anuj20.g@samsung.com, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv12 11/12] nvme: register fdp parameters with the block
 layer
Message-ID: <8d69680a-a958-4e9d-a1ba-097489fe98d1@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206221801.790690-12-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241210_004548_549091_0357EE22 
X-CRM114-Status: UNSURE (   8.89  )
X-CRM114-Notice: Please train this message.
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

Hi Keith,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/fs-add-write-stream-information-to-statx/20241207-063826
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20241206221801.790690-12-kbusch%40meta.com
patch subject: [PATCHv12 11/12] nvme: register fdp parameters with the block layer
config: csky-randconfig-r072-20241209 (https://download.01.org/0day-ci/archive/20241210/202412100319.Y5vv98P8-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202412100319.Y5vv98P8-lkp@intel.com/

New smatch warnings:
drivers/nvme/host/core.c:2187 nvme_check_fdp() error: uninitialized symbol 'i'.
drivers/nvme/host/core.c:2232 nvme_query_fdp_info() warn: missing error code 'ret'

vim +/i +2187 drivers/nvme/host/core.c

04ca0849938146 Keith Busch   2024-12-06  2154  static int nvme_check_fdp(struct nvme_ns *ns, struct nvme_ns_info *info,
04ca0849938146 Keith Busch   2024-12-06  2155  			  u8 fdp_idx)
04ca0849938146 Keith Busch   2024-12-06  2156  {
04ca0849938146 Keith Busch   2024-12-06  2157  	struct nvme_fdp_config_log hdr, *h;
04ca0849938146 Keith Busch   2024-12-06  2158  	struct nvme_fdp_config_desc *desc;
04ca0849938146 Keith Busch   2024-12-06  2159  	size_t size = sizeof(hdr);
04ca0849938146 Keith Busch   2024-12-06  2160  	int i, n, ret;
04ca0849938146 Keith Busch   2024-12-06  2161  	void *log;
04ca0849938146 Keith Busch   2024-12-06  2162  
04ca0849938146 Keith Busch   2024-12-06  2163  	info->runs = 0;
04ca0849938146 Keith Busch   2024-12-06  2164  	ret = nvme_get_log_lsi(ns->ctrl, 0, NVME_LOG_FDP_CONFIGS, 0, NVME_CSI_NVM,
04ca0849938146 Keith Busch   2024-12-06  2165  			   (void *)&hdr, size, 0, info->endgid);
04ca0849938146 Keith Busch   2024-12-06  2166  	if (ret)
04ca0849938146 Keith Busch   2024-12-06  2167  		return ret;
04ca0849938146 Keith Busch   2024-12-06  2168  
04ca0849938146 Keith Busch   2024-12-06  2169  	size = le32_to_cpu(hdr.sze);
04ca0849938146 Keith Busch   2024-12-06  2170  	h = kzalloc(size, GFP_KERNEL);
04ca0849938146 Keith Busch   2024-12-06  2171  	if (!h)
04ca0849938146 Keith Busch   2024-12-06  2172  		return 0;
04ca0849938146 Keith Busch   2024-12-06  2173  
04ca0849938146 Keith Busch   2024-12-06  2174  	ret = nvme_get_log_lsi(ns->ctrl, 0, NVME_LOG_FDP_CONFIGS, 0, NVME_CSI_NVM,
04ca0849938146 Keith Busch   2024-12-06  2175  			   h, size, 0, info->endgid);
04ca0849938146 Keith Busch   2024-12-06  2176  	if (ret)
04ca0849938146 Keith Busch   2024-12-06  2177  		goto out;
04ca0849938146 Keith Busch   2024-12-06  2178  
04ca0849938146 Keith Busch   2024-12-06  2179  	n = le16_to_cpu(h->numfdpc) + 1;
04ca0849938146 Keith Busch   2024-12-06  2180  	if (fdp_idx > n)
04ca0849938146 Keith Busch   2024-12-06  2181  		goto out;
04ca0849938146 Keith Busch   2024-12-06  2182  
04ca0849938146 Keith Busch   2024-12-06  2183  	log = h + 1;
04ca0849938146 Keith Busch   2024-12-06  2184  	do {
04ca0849938146 Keith Busch   2024-12-06  2185  		desc = log;
04ca0849938146 Keith Busch   2024-12-06  2186  		log += le16_to_cpu(desc->dsze);
04ca0849938146 Keith Busch   2024-12-06 @2187  	} while (i++ < fdp_idx);
                                                         ^
i needs to be initialized to zero at the start.

04ca0849938146 Keith Busch   2024-12-06  2188  
04ca0849938146 Keith Busch   2024-12-06  2189  	info->runs = le64_to_cpu(desc->runs);
04ca0849938146 Keith Busch   2024-12-06  2190  out:
04ca0849938146 Keith Busch   2024-12-06  2191  	kfree(h);
04ca0849938146 Keith Busch   2024-12-06  2192  	return ret;
04ca0849938146 Keith Busch   2024-12-06  2193  }
04ca0849938146 Keith Busch   2024-12-06  2194  
04ca0849938146 Keith Busch   2024-12-06  2195  static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
04ca0849938146 Keith Busch   2024-12-06  2196  {
04ca0849938146 Keith Busch   2024-12-06  2197  	struct nvme_ns_head *head = ns->head;
04ca0849938146 Keith Busch   2024-12-06  2198  	struct nvme_fdp_ruh_status *ruhs;
04ca0849938146 Keith Busch   2024-12-06  2199  	struct nvme_fdp_config fdp;
04ca0849938146 Keith Busch   2024-12-06  2200  	struct nvme_command c = {};
04ca0849938146 Keith Busch   2024-12-06  2201  	int size, ret;
04ca0849938146 Keith Busch   2024-12-06  2202  
04ca0849938146 Keith Busch   2024-12-06  2203  	ret = nvme_get_features(ns->ctrl, NVME_FEAT_FDP, info->endgid, NULL, 0,
04ca0849938146 Keith Busch   2024-12-06  2204  				&fdp);
04ca0849938146 Keith Busch   2024-12-06  2205  	if (ret)
04ca0849938146 Keith Busch   2024-12-06  2206  		goto err;
04ca0849938146 Keith Busch   2024-12-06  2207  
04ca0849938146 Keith Busch   2024-12-06  2208  	if (!(fdp.flags & FDPCFG_FDPE))
04ca0849938146 Keith Busch   2024-12-06  2209  		goto err;
04ca0849938146 Keith Busch   2024-12-06  2210  
04ca0849938146 Keith Busch   2024-12-06  2211  	ret = nvme_check_fdp(ns, info, fdp.fdpcidx);
04ca0849938146 Keith Busch   2024-12-06  2212  	if (ret || !info->runs)
04ca0849938146 Keith Busch   2024-12-06  2213  		goto err;
04ca0849938146 Keith Busch   2024-12-06  2214  
04ca0849938146 Keith Busch   2024-12-06  2215  	size = struct_size(ruhs, ruhsd, NVME_MAX_PLIDS);
04ca0849938146 Keith Busch   2024-12-06  2216  	ruhs = kzalloc(size, GFP_KERNEL);
04ca0849938146 Keith Busch   2024-12-06  2217  	if (!ruhs) {
04ca0849938146 Keith Busch   2024-12-06  2218  		ret = -ENOMEM;
04ca0849938146 Keith Busch   2024-12-06  2219  		goto err;
04ca0849938146 Keith Busch   2024-12-06  2220  	}
04ca0849938146 Keith Busch   2024-12-06  2221  
04ca0849938146 Keith Busch   2024-12-06  2222  	c.imr.opcode = nvme_cmd_io_mgmt_recv;
04ca0849938146 Keith Busch   2024-12-06  2223  	c.imr.nsid = cpu_to_le32(head->ns_id);
04ca0849938146 Keith Busch   2024-12-06  2224  	c.imr.mo = NVME_IO_MGMT_RECV_MO_RUHS;
04ca0849938146 Keith Busch   2024-12-06  2225  	c.imr.numd = cpu_to_le32(nvme_bytes_to_numd(size));
04ca0849938146 Keith Busch   2024-12-06  2226  	ret = nvme_submit_sync_cmd(ns->queue, &c, ruhs, size);
04ca0849938146 Keith Busch   2024-12-06  2227  	if (ret)
04ca0849938146 Keith Busch   2024-12-06  2228  		goto free;
04ca0849938146 Keith Busch   2024-12-06  2229  
04ca0849938146 Keith Busch   2024-12-06  2230  	head->nr_plids = le16_to_cpu(ruhs->nruhsd);
04ca0849938146 Keith Busch   2024-12-06  2231  	if (!head->nr_plids)
04ca0849938146 Keith Busch   2024-12-06 @2232  		goto free;

ret = -EINVAL?

04ca0849938146 Keith Busch   2024-12-06  2233  
04ca0849938146 Keith Busch   2024-12-06  2234  	kfree(ruhs);
04ca0849938146 Keith Busch   2024-12-06  2235  	return 0;
04ca0849938146 Keith Busch   2024-12-06  2236  
04ca0849938146 Keith Busch   2024-12-06  2237  free:
04ca0849938146 Keith Busch   2024-12-06  2238  	kfree(ruhs);
04ca0849938146 Keith Busch   2024-12-06  2239  err:
04ca0849938146 Keith Busch   2024-12-06  2240  	head->nr_plids = 0;
04ca0849938146 Keith Busch   2024-12-06  2241  	info->runs = 0;
04ca0849938146 Keith Busch   2024-12-06  2242  	return ret;
04ca0849938146 Keith Busch   2024-12-06  2243  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


