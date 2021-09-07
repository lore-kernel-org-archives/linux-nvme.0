Return-Path: <SRS0=5VvL=N5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FE7C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 20:12:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35C4F610E9
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 20:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 35C4F610E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dBV+NJaWrFdfgOWbR6kxdf2yTrJvnMOxvCmWfaHp3bg=; b=S7cJM/hP0qJeFS
	0FnDspVtihG7XFh0pJOJE5YnXlfGtp9OJfjI4TyG2sGvECTxHpfwK8uKRILYOQI3I4YHw9hyJP5VI
	Htxn5p7JmqMFkleybxjftE1kG/VnDySpFWp+ttPMPuDzYwF/E50aAhnJipUm6r7QS2Detk6RjeFz2
	C8iVcinIqx6ahjrjkNuiwVZf8SXWUWvgCkfFH9OE/XEa32FI9xnYDd/wzFslkVD0sSJmMgTv2WP9M
	1cvZ/y2wGUmDuftyLQMbLb2oAFmtnZqC6sCBX8pS8/9nXSBCp2reeYFw0nyTCX8lnpOcANWeJ3Uca
	SN/UoBv8VhL/Q8iKeKFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNhRj-004e9a-Cv; Tue, 07 Sep 2021 20:11:55 +0000
Received: from mail-dm3nam07on2056.outbound.protection.outlook.com
 ([40.107.95.56] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNhRf-004e8T-Iq
 for linux-nvme@lists.infradead.org; Tue, 07 Sep 2021 20:11:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpU45B+t6sm83iQ0vUZxwHX65fbyT4MrrnY1hbGCHAUkb8V0CHdFrK13NqL8/IoVgRjGvx2jN0eWscf4UEFjl0Fsi/SpBXmZ/IzB9Qu9i/t4urlYrDvOoY5j1nESMoVtAsiDg3a7sgPWgoEjF2PfZ1lI9kDyXIdIYwoDeT/mUa2vRKWGJm2YkbkNKdy3YVmRtVQJFVlXgGVM8qT8r4c4vIaVklcadS1qj7GS0A11ffe52rByJudTzl3qtjuzLyFtewLCiZ6qvG71/rJK/O0HzdEdjTJDNBXVVyZcMn867weYFU1aJswu8VLBVXZfEV9fJZmmXRxaFCCNtji5oFClqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=NSxEFjl02Kf9/2c9waInS4ESKtaoIhtnTUkgVR8dvA8=;
 b=cJ5Koj6nOC8qXK68DsNNZI97foFwsIguE2fjE854ppnQGNpqupmo4/RJa+GmfxLKI+zSsfCB9PPZMsmUSupkawV6CbpxGcGQOL/2tGmxPituNb8lCMISYpvUNeNSFr/s/ZHCwAJ4R6pV8Fh1mjxbbeSnbGZO9bmWL7quuDo5nEVl9VjsQjqn5Czs8ThTNNS6S0PsgDXZqG1502o0pqwF1v6C6UvnXXub3jYriAU+s0qNDpNkdgtPbTlPlESXfyPo6/R+h6n6Zm8Yfgu0S5k8ZN9fUunTF5yKN7oQj5pffFr9KEWl86eKdsD17TBlVfZmg8iUNSQEw2ZkAGjdBDbcBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSxEFjl02Kf9/2c9waInS4ESKtaoIhtnTUkgVR8dvA8=;
 b=louzEVxkzkTftGYJ6zyrZf+x3XHm6GNXA45B8JySlGnJzRgQLaptP+FFUFKtLE6UmSDSx365btKTwV5NGQil6zWENOnP8uvezAMd/e/nN1+GHLo+S/Rq29ekpoKdavJE2P9rtsklsRswbByyFY0DwBqf2sjt9G1T5SIb8Cxs/PgEb4aV6nZWqCIhrSQru2/bcdvCIUDN2EzbSY7rdPag8MC36BaoQdeZ7+0AtKttvqc4HHHL7fOJGTbT+ue8u9Xlcs+Cf4QPrnJQZK9Kq31sCrUoT3tMtw6+9rvoEgNIj2a6fFqMCK0WBsaSKjAhex1G7DRVhs2KIxBoRTqiad/I7g==
Received: from CO2PR04CA0125.namprd04.prod.outlook.com (2603:10b6:104:7::27)
 by MN2PR12MB3246.namprd12.prod.outlook.com (2603:10b6:208:af::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Tue, 7 Sep
 2021 20:11:44 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::19) by CO2PR04CA0125.outlook.office365.com
 (2603:10b6:104:7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Tue, 7 Sep 2021 20:11:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4478.19 via Frontend Transport; Tue, 7 Sep 2021 20:11:44 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 7 Sep
 2021 20:11:43 +0000
Received: from dev.nvidia.com (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 7 Sep
 2021 20:11:43 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <kbusch@kernel.org>
CC: <linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] nvme-cli: fix the [data|mdata]_len param
Date: Tue, 7 Sep 2021 13:11:36 -0700
Message-ID: <20210907201136.7715-1-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d8ac139-f6c2-4634-0af0-08d9723bb694
X-MS-TrafficTypeDiagnostic: MN2PR12MB3246:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3246BBC750F8AC8B8ED78439A3D39@MN2PR12MB3246.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:66;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ps5/F+pNRgJHEyYfiJAw73xJKWG+/aTHBRhDk5Ohj0uDyuZ6rUQ70ygv7Cmc4QA7k6xGN/MYabupwjjVQAX1LgFuzqwqfopmkdGG2hmbubzMJ1C5numj+2SAISY6HdElQ38iaflBTu+k9oKhx4KZFPr2fiaFmyxABtl2kyg7yiRXkVsU0DnhuzFeUktfF9mXb+Wux/0wG6adaGcBjIQvF3PeOR/n2TCktmsSRdrAnL1nfDEAMKVFr47R8B7cDBLLnTAXmmKFL4x6xnEg+P12WbsUyZtSLzdbwXj8FrYOWViOVe20ecQHhcYCzDKmgfGVM4GV06eD4qXEJy6NNWKczvBUA3I+SLs3st9u8SYcn+tVE5lw9OdL/4hWsKVdKJoEZ7onxQi4fwKioj40Ogm53NC7dsimg2of6e8bYfTA/ToTp2rvVQzI36X65K66zicF30nOQdwUUgpoYkpLnOuEhB6yopT4c+bqvwpc5kmYbg/QOXwWvljFe9jkFWu/kVlQrW5ndKS16bExDJ33m63x3B40cOjcSH+sIwK225SDWg4rsKPHYkejNK4u361Djqe1HMprbPzc/jnNQgJuHDoba3pOBJ4gLWh3aR5KM2Vr/EeaLiy2LMxm1DQw/XAdiXFf0jz/KOREEz71suZriyvLTaHwHdb0GpLFHB2UMf11L1201AaMJA8kuPWDeVxIyfACICsLodoQ32xmuH9GMLkIfg==
X-Forefront-Antispam-Report: CIP:216.228.112.35; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid02.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(1076003)(83380400001)(8936002)(6666004)(70586007)(316002)(36756003)(6916009)(426003)(508600001)(356005)(2906002)(16526019)(7636003)(82310400003)(186003)(7696005)(8676002)(26005)(2616005)(5660300002)(70206006)(36860700001)(86362001)(336012)(107886003)(36906005)(4326008)(54906003)(47076005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 20:11:44.0019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8ac139-f6c2-4634-0af0-08d9723bb694
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.35];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3246
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210907_131151_915549_09B5AF36 
X-CRM114-Status: GOOD (  12.49  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Chaitanya Kulkarni <kch@nvidia.com>

Add missing user data buffer and metadata buffer size parameter for the
passthru I/O commands since driver code expects these values to be set
from the user space. Without this patch blktests/nvme/029 is failing.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
Here is a test log :-

 # ./check tests/nvme/029
nvme/029 (test userspace IO via nvme-cli read/write interface) [failed]
    runtime  1.551s  ...  1.543s
    --- tests/nvme/029.out	2021-08-29 01:09:20.288901799 -0700
    +++ /mnt/data/blktests/results/nodev/nvme/029.out.bad	2021-09-07 13:08:08.011832111 -0700
    @@ -1,4 +1,10 @@
     Running nvme/029
     91fdba0d-f87b-4c25-b80f-db7be1418b9e
     uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
    +FAIL 512
    +FAIL 513
    +FAIL 513
    +FAIL 511 1024
    ...
    (Run 'diff -u tests/nvme/029.out /mnt/data/blktests/results/nodev/nvme/029.out.bad' to see the entire diff)
root@dev blktests (master) # cd -
/root/data/nvme-cli
root@dev nvme-cli ((HEAD detached from v1.15)) # git am 0001-nvme-cli-fix-the-data-mdata-_len-param.patch
Applying: nvme-cli: fix the [data|mdata]_len param
root@dev nvme-cli ((HEAD detached from v1.15)) # makej install 
NVME_VERSION = 1.15.2.ge03e
    CC nvme-print.o
    CC nvme-ioctl.o
    CC nvme-rpmb.o
    CC nvme-lightnvm.o
    CC nvme-models.o
    CC plugin.o
    CC fabrics.o
    CC nvme-filters.o
    CC nvme-status.o
    CC nvme-topology.o
    CC plugins/intel/intel-nvme.o
    CC plugins/amzn/amzn-nvme.o
    CC plugins/lnvm/lnvm-nvme.o
    CC plugins/memblaze/memblaze-nvme.o
    CC plugins/wdc/wdc-nvme.o
    CC plugins/wdc/wdc-utils.o
    CC plugins/huawei/huawei-nvme.o
    CC plugins/netapp/netapp-nvme.o
    CC plugins/toshiba/toshiba-nvme.o
    CC plugins/micron/micron-nvme.o
    CC plugins/seagate/seagate-nvme.o
    CC plugins/virtium/virtium-nvme.o
    CC plugins/shannon/shannon-nvme.o
    CC plugins/dera/dera-nvme.o
    CC plugins/scaleflux/sfx-nvme.o
    CC plugins/transcend/transcend-nvme.o
    CC plugins/zns/zns.o
    CC plugins/nvidia/nvidia-nvme.o
    CC plugins/ymtc/ymtc-nvme.o
    CC util/argconfig.o
make -C Documentation install-no-build
    CC util/parser.o
    CC util/suffix.o
install -d /usr/share/bash-completion/completions
install -d /usr/share/zsh/site-functions
    CC util/cleanup.o
install -d /etc/nvme
install -d /usr/lib/systemd/system
    CC util/log.o
install -d /etc/udev/rules.d
install -m 644 -T ./completions/bash-nvme-completion.sh /usr/share/bash-completion/completions/nvme
    CC util/json.o
install -m 644 -T ./completions/_nvme /usr/share/zsh/site-functions/_nvme
install -d /usr/lib/dracut/dracut.conf.d
touch /etc/nvme/hostnqn
install -m 644 ./nvmf-autoconnect/systemd/* /usr/lib/systemd/system
install -m 644 ./nvmf-autoconnect/udev-rules/* /etc/udev/rules.d
touch /etc/nvme/hostid
install -m 644 70-nvmf-autoconnect.conf /usr/lib/dracut/dracut.conf.d
if [ ! -f /etc/nvme/discovery.conf ]; then \
	install -m 644 -T ./etc/discovery.conf.in /etc/nvme/discovery.conf; \
fi
if [ ! -s /etc/nvme/hostnqn ]; then \
	echo `/usr/sbin/nvme gen-hostnqn` > /etc/nvme/hostnqn; \
fi
if [ ! -s /etc/nvme/hostid ]; then \
	uuidgen > /etc/nvme/hostid; \
fi
make[1]: Entering directory '/mnt/data/nvme-cli/Documentation'
install -d -m 755 /usr/local/share/man/man1
install -m 644 nvme-admin-passthru.1 nvme-ana-log.1 nvme-attach-ns.1 nvme-capacity-mgmt.1 nvme-changed-ns-list-log.1 nvme-compare.1 nvme-connect-all.1 nvme-connect.1 nvme-copy.1 nvme-create-ns.1 nvme-delete-ns.1 nvme-dera-stat.1 nvme-detach-ns.1 nvme-device-self-test.1 nvme-dir-receive.1 nvme-dir-send.1 nvme-disconnect-all.1 nvme-disconnect.1 nvme-discover.1 nvme-dsm.1 nvme-effects-log.1 nvme-endurance-event-agg-log.1 nvme-endurance-log.1 nvme-error-log.1 nvme-flush.1 nvme-format.1 nvme-fw-commit.1 nvme-fw-download.1 nvme-fw-log.1 nvme-gen-hostnqn.1 nvme-get-feature.1 nvme-get-lba-status.1 nvme-get-log.1 nvme-get-ns-id.1 nvme-get-property.1 nvme-help.1 nvme-huawei-id-ctrl.1 nvme-huawei-list.1 nvme-id-ctrl.1 nvme-id-domain.1 nvme-id-iocs.1 nvme-id-ns.1 nvme-id-nvmset.1 nvme-intel-id-ctrl.1 nvme-intel-internal-log.1 nvme-intel-lat-stats.1 nvme-intel-market-name.1 nvme-intel-smart-log-add.1 nvme-intel-temp-stats.1 nvme-io-passthru.1 nvme-lba-status-log.1 nvme-list-ctrl.1 nvme-list-ns.1 
 nvme-list-subsys.1 nvme-list.1 nvme-lnvm-create.1 nvme-lnvm-diag-bbtbl.1 nvme-lnvm-diag-set-bbtbl.1 nvme-lnvm-factory.1 nvme-lnvm-id-ns.1 nvme-lnvm-info.1 nvme-lnvm-init.1 nvme-lnvm-list.1 nvme-lnvm-remove.1 nvme-micron-clear-pcie-errors.1 nvme-micron-internal-log.1 nvme-micron-nand-stats.1 nvme-micron-pcie-stats.1 nvme-micron-selective-download.1 nvme-micron-smart-add-log.1 nvme-micron-temperature-stats.1 nvme-netapp-ontapdevices.1 nvme-netapp-smdevices.1 nvme-ns-descs.1 nvme-ns-rescan.1 nvme-nvm-id-ctrl.1 nvme-persistent-event-log.1 nvme-predictable-lat-log.1 nvme-pred-lat-event-agg-log.1 nvme-primary-ctrl-caps.1 nvme-read.1 nvme-reset.1 nvme-resv-acquire.1 nvme-resv-notif-log.1 nvme-resv-register.1 nvme-resv-release.1 nvme-resv-report.1 nvme-rpmb.1 nvme-sanitize-log.1 nvme-sanitize.1 nvme-security-recv.1 nvme-security-send.1 nvme-self-test-log.1 nvme-set-feature.1 nvme-set-property.1 nvme-show-hostnqn.1 nvme-show-regs.1 nvme-smart-log.1 nvme-subsystem-reset.1 nvme-telemetry-log.1
  nvme-toshiba-clear-pcie-correctable-errors.1 nvme-toshiba-vs-internal-log.1 nvme-toshiba-vs-smart-add-log.1 nvme-transcend-badblock.1 nvme-transcend-healthvalue.1 nvme-verify.1 nvme-virtium-save-smart-to-vtview-log.1 nvme-virtium-show-identify.1 nvme-wdc-capabilities.1 nvme-wdc-cap-diag.1 nvme-wdc-clear-assert-dump.1 nvme-wdc-clear-fw-activate-history.1 nvme-wdc-clear-pcie-correctable-errors.1 nvme-wdc-cloud-SSD-plugin-version.1 nvme-wdc-drive-essentials.1 nvme-wdc-drive-log.1 nvme-wdc-drive-resize.1 nvme-wdc-enc-get-log.1 nvme-wdc-get-crash-dump.1 nvme-wdc-get-drive-status.1 nvme-wdc-get-pfail-dump.1 nvme-wdc-id-ctrl.1 nvme-wdc-log-page-directory.1 nvme-wdc-namespace-resize.1 nvme-wdc-purge-monitor.1 nvme-wdc-purge.1 nvme-wdc-vs-drive-info.1 nvme-wdc-vs-error-reason-identifier.1 nvme-wdc-vs-fw-activate-history.1 nvme-wdc-vs-internal-log.1 nvme-wdc-vs-nand-stats.1 nvme-wdc-vs-smart-add-log.1 nvme-wdc-vs-telemetry-controller-option.1 nvme-wdc-vs-temperature-stats.1 nvme-write.1 nvme
 -write-uncor.1 nvme-write-zeroes.1 nvme-zns-changed-zone-list.1 nvme-zns-close-zone.1 nvme-zns-finish-zone.1 nvme-zns-id-ctrl.1 nvme-zns-id-ns.1 nvme-zns-offline-zone.1 nvme-zns-open-zone.1 nvme-zns-report-zones.1 nvme-zns-reset-zone.1 nvme-zns-set-zone-desc.1 nvme-zns-zone-append.1 nvme-zns-zone-mgmt-recv.1 nvme-zns-zone-mgmt-send.1 nvme.1 /usr/local/share/man/man1
make[1]: Leaving directory '/mnt/data/nvme-cli/Documentation'
    CC nvme
rm -f /usr/local/sbin/nvme
install -d /usr/sbin
install -m 755 nvme /usr/sbin
root@dev nvme-cli ((HEAD detached from v1.15)) # cd -
/root/data/blktests
root@dev blktests (master) # ./check tests/nvme/029
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  1.543s  ...  1.559s
---
 nvme-ioctl.c | 5 ++++-
 nvme-ioctl.h | 5 +++--
 nvme.c       | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index c511808..08ea160 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -126,7 +126,8 @@ int nvme_passthru(int fd, unsigned long ioctl_cmd, __u8 opcode,
 
 int nvme_io(int fd, __u8 opcode, __u32 nsid, __u64 slba, __u16 nblocks,
 		__u16 control, __u32 dsmgmt, __u32 reftag, __u16 apptag,
-		__u16 appmask, __u64 storage_tag, void *data, void *metadata)
+		__u16 appmask, __u64 storage_tag, void *data, __u32 buffer_size,
+		void *metadata, __u32 mbuffer_size)
 {
 	struct nvme_passthru_cmd cmd = {
 		.opcode		= opcode,
@@ -141,6 +142,8 @@ int nvme_io(int fd, __u8 opcode, __u32 nsid, __u64 slba, __u16 nblocks,
 		.cdw13		= dsmgmt,
 		.cdw14		= reftag,
 		.cdw15		= apptag | (appmask << 16),
+		.data_len	= buffer_size,
+		.metadata_len	= mbuffer_size,
 	};
 
 	return nvme_submit_io_passthru(fd, &cmd);
diff --git a/nvme-ioctl.h b/nvme-ioctl.h
index 2e24b83..b3fbde2 100644
--- a/nvme-ioctl.h
+++ b/nvme-ioctl.h
@@ -26,8 +26,9 @@ int nvme_passthru(int fd, unsigned long ioctl_cmd, __u8 opcode, __u8 flags,
 
 /* NVME_SUBMIT_IO */
 int nvme_io(int fd, __u8 opcode, __u32 nsid, __u64 slba, __u16 nblocks,
-	      __u16 control, __u32 dsmgmt, __u32 reftag, __u16 apptag,
-	      __u16 appmask, __u64 storage_tag, void *data, void *metadata);
+		__u16 control, __u32 dsmgmt, __u32 reftag, __u16 apptag,
+		__u16 appmask, __u64 storage_tag, void *data, __u32 buffer_size,
+		void *metadata, __u32 mbuffer_size);
 
 /* NVME_IO_CMD */
 int nvme_passthru_io(int fd, __u8 opcode, __u8 flags, __u16 rsvd,
diff --git a/nvme.c b/nvme.c
index c10932f..01ec5a2 100644
--- a/nvme.c
+++ b/nvme.c
@@ -5244,7 +5244,7 @@ static int submit_io(int opcode, char *command, const char *desc,
 	gettimeofday(&start_time, NULL);
 	err = nvme_io(fd, opcode, cfg.namespace_id, cfg.start_block, cfg.block_count,
 			 control, dsmgmt, cfg.ref_tag, cfg.app_tag, cfg.app_tag_mask,
-			 cfg.storage_tag, buffer, mbuffer);
+			 cfg.storage_tag, buffer, buffer_size, mbuffer, mbuffer_size);
 	gettimeofday(&end_time, NULL);
 	if (cfg.latency)
 		printf(" latency: %s: %llu us\n",
-- 
2.29.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
