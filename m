Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B841C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jun 2022 14:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jh+1lxbVAb0EYhpGMmIEcNt2cC5689GfxrEeQtoJZfU=; b=T3LMkxAcHL5wUcb6aj6Yfz/wzK
	bLxrjksts4A08q/oybAHdW9y+L5Jnuobwa7zB0VRw1m1++p9MsHJhYqfBD72dvDwY4jKCjxUKeQyz
	i/ztkrVupuIaX2/gDkJgEX7qCaFlZiNbc8YHElsw8MSeqcrsBx01oWKG559X5rw5oIj26cGF8tR2D
	2sYqL9R245gygYxkOgmz+EmqZ9vWInd4Fh/NOLTFYeeFPuUNYyK//M1TLtP50c8Y/QRK/LLqX9LTl
	+isOCk1rqvzz2alYbiqnns/9X8i4gdEEU0yYVWFZkttF8xhaGLYzvVucw32w12/luazrswdu+AqXQ
	GiOhd15w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5TJ8-00CBar-Qu; Sun, 26 Jun 2022 14:32:14 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5TJ6-00CBaB-76
	for linux-nvme@lists.infradead.org; Sun, 26 Jun 2022 14:32:13 +0000
Received: by mail-wr1-f44.google.com with SMTP id n1so9531946wrg.12
        for <linux-nvme@lists.infradead.org>; Sun, 26 Jun 2022 07:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jh+1lxbVAb0EYhpGMmIEcNt2cC5689GfxrEeQtoJZfU=;
        b=3XPFzBzWpxYEavDw/O9fSm0s77B8LvUjRoHGUHw1qHnOAnDaMA+1pqF3MXV0P7apLz
         vfzZupc7TYGb4kZGe4ev3/YHE9161FGuPsNbMuCD6e4d9sX3g8HW08inv+82Dd9Qs9EB
         e6XUirp1XzH5cLuZdpi7D0COAOArwvezwvVKYMifUXN6Vg8e/KS/c/koMjuAL+bSjdMz
         R0/vBK/Zn4OjF3RyTUG5uSsz/TC71WmVdfGtotgZtIrdF6S/BakDk9utAj/rtgKUK4AU
         VEabDXB0uKwnvOSd+m5/YbfbTb+06M2vLnARyOTw1YH2WED7noVCGzrHuhxQcCLSqBIM
         tUoA==
X-Gm-Message-State: AJIora/RfrenEglkmMSR/5nzrjLUIK5Rm39dGNCCHgs51/by+QlrqGlD
	N1hZis970vLfcRPFacNeAxw=
X-Google-Smtp-Source: AGRyM1svwDmK90D7tHjhbmXabgbYAhXJNhEKReVhRw5M9YkBCsB6SGskB3p9LE29Tc6l1/79w4kvgw==
X-Received: by 2002:a05:6000:1844:b0:21b:b06f:a3a1 with SMTP id c4-20020a056000184400b0021bb06fa3a1mr8519159wri.357.1656253930401;
        Sun, 26 Jun 2022 07:32:10 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t7-20020a05600001c700b002167efdd549sm7781944wrx.38.2022.06.26.07.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 07:32:10 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: add optional ipv6 test flavor
Date: Sun, 26 Jun 2022 17:32:08 +0300
Message-Id: <20220626143208.84997-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220626_073212_296082_09BD52F6 
X-CRM114-Status: GOOD (  12.02  )
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

Allow Setting nvme_adrfam=[ipv4|ipv6] and running tests on either
address family. Ignored for non IP transports.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 common/multipath-over-rdma | 10 ++++++++++
 tests/nvme/rc              | 31 ++++++++++++++++++++++++++++---
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index f9d7b9a236ce..4307ceb4aae1 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -74,6 +74,16 @@ get_ipv6_addr() {
 		sed -n 's/.*[[:blank:]]inet6[[:blank:]]*\([^[:blank:]/]*\).*/\1/p'
 }
 
+# grab only the link local address
+get_ipv6_ll_addr() {
+	if [ ! -e "/sys/class/net/$1" ]; then
+		echo "get_ipv6_addr(): $1 is not a network interface" 1>&2
+	fi
+	ll_addr=$(ip -6 -o addr show dev "$1" | grep "scope link" |
+		sed -n 's/.*[[:blank:]]inet6[[:blank:]]*\([^[:blank:]/]*\).*/\1/p')
+	echo "$ll_addr%$1"
+}
+
 # Whether or not $1 is a number.
 is_number() {
 	[ "$1" -eq "0$1" ] 2>/dev/null
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 998b18164306..b36cc19ec3c1 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -38,6 +38,24 @@ _nvme_requires() {
 		SKIP_REASON="unsupported nvme_trtype=${nvme_trtype}"
 		return 1
 	esac
+
+	if [[ ! -z ${nvme_adrfam} ]]; then
+		case ${nvme_adrfam} in
+		ipv6)
+			def_traddr="::1"
+			def_adrfam="ipv6"
+			;;
+		ipv4)
+			;; # was already set
+		*)
+			# ignore for non ip transports
+			if [[ "${nvme_trtype}" == "tcp" || "${nvme_trtype}" == "rdma" ]]; then
+				SKIP_REASON="unsupported nvme_adrfam=${nvme_adrfam}"
+				return 1
+			fi
+		esac
+	fi
+
 	return 0
 }
 
@@ -148,9 +166,16 @@ _setup_nvmet() {
 		start_soft_rdma
 		for i in $(rdma_network_interfaces)
 		do
-			ipv4_addr=$(get_ipv4_addr "$i")
-			if [ -n "${ipv4_addr}" ]; then
-				def_traddr=${ipv4_addr}
+			if [[ "${nvme_adrfam}" == "ipv6" ]]; then
+				ipv6_addr=$(get_ipv6_ll_addr "$i")
+				if [ -n "${ipv6_addr}" ]; then
+					def_traddr=${ipv6_addr}
+				fi
+			else
+				ipv4_addr=$(get_ipv4_addr "$i")
+				if [ -n "${ipv4_addr}" ]; then
+					def_traddr=${ipv4_addr}
+				fi
 			fi
 		done
 	fi
-- 
2.34.1


