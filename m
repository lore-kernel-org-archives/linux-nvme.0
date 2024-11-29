Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BD7D66BAF
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 06:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=IVUxBSUNvdeHNHiOrdis1Hj8AobdMbzIY2O+fKcm03o=; b=wQ4VeT8QOf8I8I
	f54JGbBEPdm3s4RVC1s6SA2vCB2rniuN28H8xsZcQmlqwNOikIA930dT9IGAqeNEZ4lQd/B9FVVJR
	GPUrMN6Fo3LhYaG8/NBfUPHiencVYjhjzKayMF18UmYz5D0aYzyphhd7QNML7Z6nolkyK6VQEuJpO
	XoTIv0fyfkf0VIV6/GBGMizH5swvBy4tlVKtsMOsUMMW01TfoqgFnLxCvfcF0agJebpwyewvdorRW
	3ePC8zmPKj3/MO2zt40i+g9McT+KEUt3hzoI0Fggo8ltuJqe818Myn8mVbMpLv0PRc/EzSCDm5V5t
	bIl55D/56ogebAwD3AAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGuZh-0000000H0wZ-2I6j;
	Fri, 29 Nov 2024 06:33:57 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGuZe-0000000H0vs-1Ire
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 06:33:56 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241129063349epoutp01899be58d2d2f8d9d0068683ea401d3a3~MXNXOShOy0323903239epoutp01c
	for <linux-nvme@lists.infradead.org>; Fri, 29 Nov 2024 06:33:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241129063349epoutp01899be58d2d2f8d9d0068683ea401d3a3~MXNXOShOy0323903239epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1732862030;
	bh=IVUxBSUNvdeHNHiOrdis1Hj8AobdMbzIY2O+fKcm03o=;
	h=From:To:Cc:Subject:Date:References:From;
	b=jmRZB3L4bwYSVoT640pQChbtzog5MbBVaTqJuAzFgT+jnhNctebMkj4YmPM14FCPC
	 UVTUjxJK2Du6bszGEJ10Hz/bOZYDNWCftlaHfu7FQP3Z/aqJo4irSX6EHc/S3fKdW5
	 OKXIuy4l9fkwOAcoRRQznQoxgJ2Fy3ShswpLqqtM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241129063349epcas5p47c7d46457376a2bac43a09f94dbff7c0~MXNW-o_oX0518205182epcas5p4N;
	Fri, 29 Nov 2024 06:33:49 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Y03Km39BHz4x9Q9; Fri, 29 Nov
	2024 06:33:48 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A6.11.29212.A4069476; Fri, 29 Nov 2024 15:33:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241129061514epcas5p48af9d40e58ddf2acf92652031cb09eb0~MW9IdJHMQ1570515705epcas5p4j;
	Fri, 29 Nov 2024 06:15:14 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241129061514epsmtrp147673f9c6faf24b294aadb87aeaab9ef~MW9IcECd_0974409744epsmtrp1O;
	Fri, 29 Nov 2024 06:15:14 +0000 (GMT)
X-AuditID: b6c32a50-7ebff7000000721c-b6-6749604a9449
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	B2.C8.33707.2FB59476; Fri, 29 Nov 2024 15:15:14 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241129061514epsmtip2f5553780a9c4daf445c818af809d2b9e~MW9H79M_m2632926329epsmtip2G;
	Fri, 29 Nov 2024 06:15:13 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: linux-nvme@lists.infradead.org
Cc: Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCH nvme-cli] nvme: plugins/fdp, check endurance group
 identifier
Date: Fri, 29 Nov 2024 11:37:16 +0530
Message-Id: <20241129060716.4710-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7bCmpq5Xgme6wcYuE4v5y56yW2z7PZ/Z
	gclj85J6j74tqxgDmKKybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1Nt
	lVx8AnTdMnOAxisplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL89L1
	8lJLrAwNDIxMgQoTsjNeHF7FXHCbs2Lh+y3MDYwf2LsYOTkkBEwkHt9+wtzFyMUhJLCHUeLK
	uUtQzidGif3zZjHBOSun/GTrYuQAa2mdJQrSLSSwk1Gi4YIcRE0rk8S/ffdZQGrYBLQlTv/n
	AKkREVCS+Lu+iQXEZhbQlOiecZ8VxBYW8Jd493g/E0g5i4CqxJlXQSBhXgFLiekb25kgjpOX
	WL3hANg9EgKf2STu3vnLDJFwkZh95zbUB8ISr45vgbKlJF72t0HZ5UAnr2CDaG5hlJh1fRYj
	RMJeovVUPzPIYpCD1u/ShwjLSkw9tY4J4k4+id7fT6CO4JXYMQ/GVpZYs34BG4QtKXHteyOU
	7SHxev5CJkiYxEp8efSCfQKj7CyEDQsYGVcxSqUWFOempyabFhjq5qWWw+MpOT93EyM40WgF
	7GBcveGv3iFGJg7GQ4wSHMxKIrxXFnukC/GmJFZWpRblxxeV5qQWH2I0BQbaRGYp0eR8YKrL
	K4k3NLE0MDEzMzOxNDYzVBLnfd06N0VIID2xJDU7NbUgtQimj4mDU6qBqfHGZscvJ2bITos+
	JcCskKsbWsX+PkU56+SHTb6afvaX39jsOLX74sEfBo8ZT6QkXe60Kvy69K6n9Y1pZruX+26p
	SlmTtEPavOd0ncSnprqo04leT1ecCv+tl1uwZIHJI22He4nb34b8f9ock23hr/N7uc16/zcn
	9I2ctdsWsirssXqYW77G1v5fdjhn+J831umqzKKTzuor/c29ZhS/WPTC4lMHjBxNslNPHFle
	99zeaotVfrVJrd6kL3uz9fNz1kkEe1ULnq3L4++RPiHZ1nFeqnJOadbLN9sFO9k0Fr1STfoW
	9evsafnVRxskdq98+CetmeE1g8bZ7SVCrkZ6RnvbtolKZ2ns+lw7Va9NiaU4I9FQi7moOBEA
	ZmcCFb0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAJMWRmVeSWpSXmKPExsWy7bCSvO6naM90g4c9Chbzlz1lt9j2ez6z
	A5PH5iX1Hn1bVjEGMEVx2aSk5mSWpRbp2yVwZbw4vIq54DZnxcL3W5gbGD+wdzFycEgImEi0
	zhLtYuTiEBLYzijxfMdati5GTqC4pMSyv0eYIWxhiZX/nrNDFDUzSTw9/YwFpJlNQFvi9H8O
	kBoRASWJv+ubWEBsZgFNie4Z91lBbGEBX4mD+yeygpSzCKhKnHkVBBLmFbCUmL6xnQlivLzE
	6g0HmCcw8ixgZFjFKJpaUJybnptcYKhXnJhbXJqXrpecn7uJEexpraAdjMvW/9U7xMjEwXiI
	UYKDWUmE98pij3Qh3pTEyqrUovz4otKc1OJDjNIcLErivMo5nSlCAumJJanZqakFqUUwWSYO
	TqkGJkmmVStW1WT7au7a0ltZUaOS+1XwoqLY8/DvEhJHNkiXzlUJ3ud85vSBF/8+Rr2r2fj1
	znEV5wUL4w/G9wt4Bekf3LK3J0tM+VvuOptjXw1ev/rwmnPCfP+yWT+ucElMzzh59DfH9pDO
	JTzufhx2Z5v3hP1ba2uTsUZ82sXW1WLMB/9LW1eLtt+RfcNxStFyVusJeUv/TW0X/DKiORoi
	RF3itikuNbS4s+P6kT9X/YSOfLFpfePTprrQRyxL1q5/4vpHOufPbjj8fI7mz0umibeUpb7I
	n3orUq+S95VXuvfLN6tzb/N2HV2ldjjr/g6Xq7Pyrpfxf+CTOiD0cd0VpcAnZuktZSc3rDLN
	2rfg/08lluKMREMt5qLiRACp7pmOYwIAAA==
X-CMS-MailID: 20241129061514epcas5p48af9d40e58ddf2acf92652031cb09eb0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241129061514epcas5p48af9d40e58ddf2acf92652031cb09eb0
References: <CGME20241129061514epcas5p48af9d40e58ddf2acf92652031cb09eb0@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_223354_814129_55C9F503 
X-CRM114-Status: GOOD (  16.25  )
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

For FDP options such as stats and events, default endurance identifier 0
is used which results in error.
This patch returns error for missing endurance group identifier from
user.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 plugins/fdp/fdp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/plugins/fdp/fdp.c b/plugins/fdp/fdp.c
index cac0b2bd..c61706ac 100644
--- a/plugins/fdp/fdp.c
+++ b/plugins/fdp/fdp.c
@@ -215,6 +215,12 @@ static int fdp_stats(int argc, char **argv, struct command *cmd, struct plugin *
 	if (cfg.raw_binary)
 		flags = BINARY;
 
+	if (!cfg.egid) {
+		fprintf(stderr, "endurance group identifier required\n");
+		err = -EINVAL;
+		goto out;
+	}
+
 	memset(&stats, 0x0, sizeof(stats));
 
 	err = nvme_get_log_fdp_stats(dev->direct.fd, cfg.egid, 0, sizeof(stats), &stats);
@@ -276,6 +282,12 @@ static int fdp_events(int argc, char **argv, struct command *cmd, struct plugin
 	if (cfg.raw_binary)
 		flags = BINARY;
 
+	if (!cfg.egid) {
+		fprintf(stderr, "endurance group identifier required\n");
+		err = -EINVAL;
+		goto out;
+	}
+
 	memset(&events, 0x0, sizeof(events));
 
 	err = nvme_get_log_fdp_events(dev->direct.fd, cfg.egid,
-- 
2.34.1


