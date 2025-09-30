Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64D1CCA470
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Sep 2025 15:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0YmYMffsAzZLDjj5w8zwng0Sd3OeN0u+X6SgZMlkAWY=; b=cezjru7BzBLKVn3lnorbSqTad0
	TQw4okhG8gRPVMtPhpm3VY9kHz7f7S7hb5HnMIW4h4lQiYmh/dqS7ZDqRHFSFQzYRbIIr7CY6nR40
	jD5ig1njAghPDdMaWka5cD243DtRhPM5EC4x1TbKEdN46vUJpTs+7MZJPXIiFyGyIqj2cBuXf8k7I
	3ykSDfbyXz9oMQvliYMrTqyh4JrJBBPnuWgnEqj0LCqw+vce2qtZ/jTJkmNbURiBgz/9cxYJJ9TGF
	qUOfBHSQXbAviyCPuNQUG0IG9KXfENy6qgjygCSK+/O0RN797ug5RWE3fvSRyyvdwT3qK6su+3NZM
	+PieaKdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3cYU-00000005ger-1XaB;
	Tue, 30 Sep 2025 15:46:18 +0000
Received: from mgamail.intel.com ([192.198.163.17])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3cYR-00000005geP-00GZ
	for linux-nvme@lists.infradead.org;
	Tue, 30 Sep 2025 15:46:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759247175; x=1790783175;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P4//oljz5XRai1nYVCHqTptrJc8VvEvo3tqUIAxLPE8=;
  b=nwzqVWA94VPUVhFKVEzzcrbKud4GjNYk2JqExVx+biUW1+CnNOJwXIWl
   /jNHgboX0vfNTpsokkdLZw6ULAGK7GwsVCinbDHxYpiDCZ//x+wUCNytC
   0eD+BDngRJvSoMOZmmLyyGKiiID7DLdPvXyebUJFMP+Xb4rQh2Vj0EDvj
   D7lRMJFrcsEusAHOkQnh5PJm8UCYIlKHPkCY6ipxaZ9NSD3vbhUbQas07
   0EFvHKW2rFKM2P0rs113yhXumf2a55hgBP1u2Ybu8OoKKdmHTlKBBcfIW
   Hp0jPdKipsKW6NgDDRTnGzxRA8dL23/x11gdYLYL4ELt5SyzdWXLHUwR0
   g==;
X-CSE-ConnectionGUID: VfPksjV7Q8O/pwJmXMh9lA==
X-CSE-MsgGUID: g8l375oMR8mAMD+QVODDuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61425293"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="61425293"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 08:46:11 -0700
X-CSE-ConnectionGUID: 38q57Z+UQeenUU3V1Mf9LQ==
X-CSE-MsgGUID: j0pV5D/1R6iHx8nMLx3YPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="179315050"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 30 Sep 2025 08:46:10 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v3cYJ-0002Ep-2u;
	Tue, 30 Sep 2025 15:46:07 +0000
Date: Tue, 30 Sep 2025 23:45:27 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Subject: [linux-nvme:nvme-6.18 6/11]
 drivers/nvme/host/fabrics.c:1097:undefined reference to
 `nvme_auth_extract_key'
Message-ID: <202509302359.TL1868ni-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250930_084615_121334_C7EF0A2C 
X-CRM114-Status: GOOD (  13.39  )
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

tree:   git://git.infradead.org/nvme.git nvme-6.18
head:   876f5e3e3b1e3e78aec9b7e53bec4b949a13ce09
commit: 593a56d90ae8edc9ed64e5d3893b69fbbde77bba [6/11] nvme: parse dhchap keys during option parsing
config: csky-randconfig-002-20250930 (https://download.01.org/0day-ci/archive/20250930/202509302359.TL1868ni-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250930/202509302359.TL1868ni-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509302359.TL1868ni-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/nvme/host/fabrics.o: in function `nvmf_parse_options':
>> drivers/nvme/host/fabrics.c:1097:(.text+0x166c): undefined reference to `nvme_auth_extract_key'
>> csky-linux-ld: drivers/nvme/host/fabrics.c:1112:(.text+0x16e2): undefined reference to `nvme_auth_extract_key'
   csky-linux-ld: drivers/nvme/host/fabrics.c:1145:(.text+0x17b8): undefined reference to `nvme_auth_extract_key'


vim +1097 drivers/nvme/host/fabrics.c

   715	
   716	static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
   717			const char *buf)
   718	{
   719		substring_t args[MAX_OPT_ARGS];
   720		char *options, *o, *p;
   721		char *host_secret = NULL, *ctrl_secret = NULL;
   722		int token, ret = 0;
   723		size_t nqnlen  = 0;
   724		int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO, key_id;
   725		uuid_t hostid;
   726		char hostnqn[NVMF_NQN_SIZE];
   727		struct key *key;
   728	
   729		/* Set defaults */
   730		opts->queue_size = NVMF_DEF_QUEUE_SIZE;
   731		opts->nr_io_queues = num_online_cpus();
   732		opts->reconnect_delay = NVMF_DEF_RECONNECT_DELAY;
   733		opts->kato = 0;
   734		opts->duplicate_connect = false;
   735		opts->fast_io_fail_tmo = NVMF_DEF_FAIL_FAST_TMO;
   736		opts->hdr_digest = false;
   737		opts->data_digest = false;
   738		opts->tos = -1; /* < 0 == use transport default */
   739		opts->tls = false;
   740		opts->tls_key = NULL;
   741		opts->keyring = NULL;
   742		opts->concat = false;
   743		opts->dhchap_key = NULL;
   744		opts->dhchap_ctrl_key = NULL;
   745	
   746		options = o = kstrdup(buf, GFP_KERNEL);
   747		if (!options)
   748			return -ENOMEM;
   749	
   750		/* use default host if not given by user space */
   751		uuid_copy(&hostid, &nvmf_default_host->id);
   752		strscpy(hostnqn, nvmf_default_host->nqn, NVMF_NQN_SIZE);
   753	
   754		while ((p = strsep(&o, ",\n")) != NULL) {
   755			if (!*p)
   756				continue;
   757	
   758			token = match_token(p, opt_tokens, args);
   759			opts->mask |= token;
   760			switch (token) {
   761			case NVMF_OPT_TRANSPORT:
   762				p = match_strdup(args);
   763				if (!p) {
   764					ret = -ENOMEM;
   765					goto out;
   766				}
   767				kfree(opts->transport);
   768				opts->transport = p;
   769				break;
   770			case NVMF_OPT_NQN:
   771				p = match_strdup(args);
   772				if (!p) {
   773					ret = -ENOMEM;
   774					goto out;
   775				}
   776				kfree(opts->subsysnqn);
   777				opts->subsysnqn = p;
   778				nqnlen = strlen(opts->subsysnqn);
   779				if (nqnlen >= NVMF_NQN_SIZE) {
   780					pr_err("%s needs to be < %d bytes\n",
   781						opts->subsysnqn, NVMF_NQN_SIZE);
   782					ret = -EINVAL;
   783					goto out;
   784				}
   785				opts->discovery_nqn =
   786					!(strcmp(opts->subsysnqn,
   787						 NVME_DISC_SUBSYS_NAME));
   788				break;
   789			case NVMF_OPT_TRADDR:
   790				p = match_strdup(args);
   791				if (!p) {
   792					ret = -ENOMEM;
   793					goto out;
   794				}
   795				kfree(opts->traddr);
   796				opts->traddr = p;
   797				break;
   798			case NVMF_OPT_TRSVCID:
   799				p = match_strdup(args);
   800				if (!p) {
   801					ret = -ENOMEM;
   802					goto out;
   803				}
   804				kfree(opts->trsvcid);
   805				opts->trsvcid = p;
   806				break;
   807			case NVMF_OPT_QUEUE_SIZE:
   808				if (match_int(args, &token)) {
   809					ret = -EINVAL;
   810					goto out;
   811				}
   812				if (token < NVMF_MIN_QUEUE_SIZE ||
   813				    token > NVMF_MAX_QUEUE_SIZE) {
   814					pr_err("Invalid queue_size %d\n", token);
   815					ret = -EINVAL;
   816					goto out;
   817				}
   818				opts->queue_size = token;
   819				break;
   820			case NVMF_OPT_NR_IO_QUEUES:
   821				if (match_int(args, &token)) {
   822					ret = -EINVAL;
   823					goto out;
   824				}
   825				if (token <= 0) {
   826					pr_err("Invalid number of IOQs %d\n", token);
   827					ret = -EINVAL;
   828					goto out;
   829				}
   830				if (opts->discovery_nqn) {
   831					pr_debug("Ignoring nr_io_queues value for discovery controller\n");
   832					break;
   833				}
   834	
   835				opts->nr_io_queues = min_t(unsigned int,
   836						num_online_cpus(), token);
   837				break;
   838			case NVMF_OPT_KATO:
   839				if (match_int(args, &token)) {
   840					ret = -EINVAL;
   841					goto out;
   842				}
   843	
   844				if (token < 0) {
   845					pr_err("Invalid keep_alive_tmo %d\n", token);
   846					ret = -EINVAL;
   847					goto out;
   848				} else if (token == 0 && !opts->discovery_nqn) {
   849					/* Allowed for debug */
   850					pr_warn("keep_alive_tmo 0 won't execute keep alives!!!\n");
   851				}
   852				opts->kato = token;
   853				break;
   854			case NVMF_OPT_CTRL_LOSS_TMO:
   855				if (match_int(args, &token)) {
   856					ret = -EINVAL;
   857					goto out;
   858				}
   859	
   860				if (token < 0)
   861					pr_warn("ctrl_loss_tmo < 0 will reconnect forever\n");
   862				ctrl_loss_tmo = token;
   863				break;
   864			case NVMF_OPT_FAIL_FAST_TMO:
   865				if (match_int(args, &token)) {
   866					ret = -EINVAL;
   867					goto out;
   868				}
   869	
   870				if (token >= 0)
   871					pr_warn("I/O fail on reconnect controller after %d sec\n",
   872						token);
   873				else
   874					token = -1;
   875	
   876				opts->fast_io_fail_tmo = token;
   877				break;
   878			case NVMF_OPT_HOSTNQN:
   879				if (opts->host) {
   880					pr_err("hostnqn already user-assigned: %s\n",
   881					       opts->host->nqn);
   882					ret = -EADDRINUSE;
   883					goto out;
   884				}
   885				p = match_strdup(args);
   886				if (!p) {
   887					ret = -ENOMEM;
   888					goto out;
   889				}
   890				nqnlen = strlen(p);
   891				if (nqnlen >= NVMF_NQN_SIZE) {
   892					pr_err("%s needs to be < %d bytes\n",
   893						p, NVMF_NQN_SIZE);
   894					kfree(p);
   895					ret = -EINVAL;
   896					goto out;
   897				}
   898				strscpy(hostnqn, p, NVMF_NQN_SIZE);
   899				kfree(p);
   900				break;
   901			case NVMF_OPT_RECONNECT_DELAY:
   902				if (match_int(args, &token)) {
   903					ret = -EINVAL;
   904					goto out;
   905				}
   906				if (token <= 0) {
   907					pr_err("Invalid reconnect_delay %d\n", token);
   908					ret = -EINVAL;
   909					goto out;
   910				}
   911				opts->reconnect_delay = token;
   912				break;
   913			case NVMF_OPT_HOST_TRADDR:
   914				p = match_strdup(args);
   915				if (!p) {
   916					ret = -ENOMEM;
   917					goto out;
   918				}
   919				kfree(opts->host_traddr);
   920				opts->host_traddr = p;
   921				break;
   922			case NVMF_OPT_HOST_IFACE:
   923				p = match_strdup(args);
   924				if (!p) {
   925					ret = -ENOMEM;
   926					goto out;
   927				}
   928				kfree(opts->host_iface);
   929				opts->host_iface = p;
   930				break;
   931			case NVMF_OPT_HOST_ID:
   932				p = match_strdup(args);
   933				if (!p) {
   934					ret = -ENOMEM;
   935					goto out;
   936				}
   937				ret = uuid_parse(p, &hostid);
   938				if (ret) {
   939					pr_err("Invalid hostid %s\n", p);
   940					ret = -EINVAL;
   941					kfree(p);
   942					goto out;
   943				}
   944				kfree(p);
   945				break;
   946			case NVMF_OPT_DUP_CONNECT:
   947				opts->duplicate_connect = true;
   948				break;
   949			case NVMF_OPT_DISABLE_SQFLOW:
   950				opts->disable_sqflow = true;
   951				break;
   952			case NVMF_OPT_HDR_DIGEST:
   953				opts->hdr_digest = true;
   954				break;
   955			case NVMF_OPT_DATA_DIGEST:
   956				opts->data_digest = true;
   957				break;
   958			case NVMF_OPT_NR_WRITE_QUEUES:
   959				if (match_int(args, &token)) {
   960					ret = -EINVAL;
   961					goto out;
   962				}
   963				if (token <= 0) {
   964					pr_err("Invalid nr_write_queues %d\n", token);
   965					ret = -EINVAL;
   966					goto out;
   967				}
   968				opts->nr_write_queues = token;
   969				break;
   970			case NVMF_OPT_NR_POLL_QUEUES:
   971				if (match_int(args, &token)) {
   972					ret = -EINVAL;
   973					goto out;
   974				}
   975				if (token <= 0) {
   976					pr_err("Invalid nr_poll_queues %d\n", token);
   977					ret = -EINVAL;
   978					goto out;
   979				}
   980				opts->nr_poll_queues = token;
   981				break;
   982			case NVMF_OPT_TOS:
   983				if (match_int(args, &token)) {
   984					ret = -EINVAL;
   985					goto out;
   986				}
   987				if (token < 0) {
   988					pr_err("Invalid type of service %d\n", token);
   989					ret = -EINVAL;
   990					goto out;
   991				}
   992				if (token > 255) {
   993					pr_warn("Clamping type of service to 255\n");
   994					token = 255;
   995				}
   996				opts->tos = token;
   997				break;
   998			case NVMF_OPT_KEYRING:
   999				if (match_int(args, &key_id) || key_id <= 0) {
  1000					ret = -EINVAL;
  1001					goto out;
  1002				}
  1003				key = nvmf_parse_key(key_id);
  1004				if (IS_ERR(key)) {
  1005					ret = PTR_ERR(key);
  1006					goto out;
  1007				}
  1008				key_put(opts->keyring);
  1009				opts->keyring = key;
  1010				break;
  1011			case NVMF_OPT_TLS_KEY:
  1012				if (match_int(args, &key_id) || key_id <= 0) {
  1013					ret = -EINVAL;
  1014					goto out;
  1015				}
  1016				key = nvmf_parse_key(key_id);
  1017				if (IS_ERR(key)) {
  1018					ret = PTR_ERR(key);
  1019					goto out;
  1020				}
  1021				key_put(opts->tls_key);
  1022				opts->tls_key = key;
  1023				break;
  1024			case NVMF_OPT_DISCOVERY:
  1025				opts->discovery_nqn = true;
  1026				break;
  1027			case NVMF_OPT_DHCHAP_SECRET:
  1028				p = match_strdup(args);
  1029				if (!p) {
  1030					ret = -ENOMEM;
  1031					goto out;
  1032				}
  1033				kfree(host_secret);
  1034				host_secret = p;
  1035				break;
  1036			case NVMF_OPT_DHCHAP_CTRL_SECRET:
  1037				p = match_strdup(args);
  1038				if (!p) {
  1039					ret = -ENOMEM;
  1040					goto out;
  1041				}
  1042				kfree(ctrl_secret);
  1043				ctrl_secret = p;
  1044				break;
  1045			case NVMF_OPT_TLS:
  1046				if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
  1047					pr_err("TLS is not supported\n");
  1048					ret = -EINVAL;
  1049					goto out;
  1050				}
  1051				opts->tls = true;
  1052				break;
  1053			case NVMF_OPT_CONCAT:
  1054				if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
  1055					pr_err("TLS is not supported\n");
  1056					ret = -EINVAL;
  1057					goto out;
  1058				}
  1059				opts->concat = true;
  1060				break;
  1061			default:
  1062				pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
  1063					p);
  1064				ret = -EINVAL;
  1065				goto out;
  1066			}
  1067		}
  1068	
  1069		if (opts->discovery_nqn) {
  1070			opts->nr_io_queues = 0;
  1071			opts->nr_write_queues = 0;
  1072			opts->nr_poll_queues = 0;
  1073			opts->duplicate_connect = true;
  1074		} else {
  1075			if (!opts->kato)
  1076				opts->kato = NVME_DEFAULT_KATO;
  1077		}
  1078		if (ctrl_loss_tmo < 0) {
  1079			opts->max_reconnects = -1;
  1080		} else {
  1081			opts->max_reconnects = DIV_ROUND_UP(ctrl_loss_tmo,
  1082							opts->reconnect_delay);
  1083			if (ctrl_loss_tmo < opts->fast_io_fail_tmo)
  1084				pr_warn("failfast tmo (%d) larger than controller loss tmo (%d)\n",
  1085					opts->fast_io_fail_tmo, ctrl_loss_tmo);
  1086		}
  1087	
  1088		opts->host = nvmf_host_add(hostnqn, &hostid);
  1089		if (IS_ERR(opts->host)) {
  1090			ret = PTR_ERR(opts->host);
  1091			opts->host = NULL;
  1092			goto out;
  1093		}
  1094	
  1095		if (host_secret) {
  1096			pr_debug("lookup host identity '%s'\n", host_secret);
> 1097			key = nvme_auth_extract_key(opts->keyring, host_secret,
  1098						    strlen(host_secret));
  1099			if (IS_ERR(key)) {
  1100				ret = PTR_ERR(key);
  1101				goto out;
  1102			}
  1103			pr_debug("using dhchap key %08x\n", key_serial(key));
  1104			opts->dhchap_key = key;
  1105		}
  1106		if (ctrl_secret) {
  1107			if (!opts->dhchap_key) {
  1108				ret = -EINVAL;
  1109				goto out;
  1110			}
  1111			pr_debug("lookup ctrl identity '%s'\n", ctrl_secret);
> 1112			key = nvme_auth_extract_key(opts->keyring, ctrl_secret,
  1113						    strlen(ctrl_secret));
  1114			if (IS_ERR(key)) {
  1115				ret = PTR_ERR(key);
  1116				goto out;
  1117			}
  1118			pr_debug("using dhchap ctrl key %08x\n", key_serial(key));
  1119			opts->dhchap_ctrl_key = key;
  1120		}
  1121	
  1122		if (opts->concat) {
  1123			if (opts->tls) {
  1124				pr_err("Secure concatenation over TLS is not supported\n");
  1125				ret = -EINVAL;
  1126				goto out;
  1127			}
  1128			if (opts->tls_key) {
  1129				pr_err("Cannot specify a TLS key for secure concatenation\n");
  1130				ret = -EINVAL;
  1131				goto out;
  1132			}
  1133			if (!opts->dhchap_key) {
  1134				pr_err("Need to enable DH-CHAP for secure concatenation\n");
  1135				ret = -EINVAL;
  1136				goto out;
  1137			}
  1138		}
  1139	
  1140	out:
  1141		kfree(ctrl_secret);
  1142		kfree(host_secret);
  1143		kfree(options);
  1144		return ret;
  1145	}
  1146	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

