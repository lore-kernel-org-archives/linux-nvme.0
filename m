Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA68CC9EC6D
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jan 2026 11:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eVlY/tju4C7/B/qsWQ7m8i3xt+Cr5X87fuFaUw+gXkM=; b=pjMVWbfRtcNyPfIlXXmnYJbzpx
	/Swp1gIymC+plWnhxX5lfwpXLJiPsicHwLm8hn/olWi+2JAOjpQDGna37XKe3ygNTGi3QdvBKjB9l
	3bZn4eF5bpJnWzqS51PYBZmO8dfZrOe+QZYkMMPZ+CoaszwRJ3YpiRh4iyt5oCn/i3+Fh7hMAPY5c
	l7aaymGXTqISktIc0v1H/46S/l3IsdrBsZJMWLw+qD1MRh28SZVtjqmDsBRrI78tKDEsnTcTjEC20
	tWPRH9ChzdbhpQc0ctzCgEa4wQ8H3kpf+vsc0EHh/m9iqABShLTtcbLXslFloIBKaf9FwEjgq28xx
	vY9jIpXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfFve-00000005E5t-3eYj;
	Mon, 12 Jan 2026 11:17:46 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfFvc-00000005E4h-2wpt
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jan 2026 11:17:45 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60BMiL7q019847;
	Mon, 12 Jan 2026 11:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eVlY/t
	ju4C7/B/qsWQ7m8i3xt+Cr5X87fuFaUw+gXkM=; b=ah1tPK2PkaXq6TkhN9TFCb
	jugEkQkg5ihq+HhUXGyOEyh0ny8M7IPAZlBgIKHXb9w9K/ou7TRP1TV7ho7dnlqg
	wm7rvcqv6YbcBikvE59zk4NkOogOmBkzT639YSejEBIHPTQ5rgjCYgtGmJeiGMrD
	W4SNbCs03UH1CX9slQXXJZ4tk0Tu71P8vvN/Av4wQEQf+kgPXUOY+SvV4M3NwD8G
	4Uo4bLjOFXgBqpsrBeDNwm/q+hyOh4pIIt/mvKpIR9cvxp4e4NrU7kfRItI6Ttdl
	cCiulMhzVEAF+6ErvCDieP9XsPgpYZWy0DkuPTfaY4hXpLJG16XfiZc0jNnJvnTg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedspen8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 11:17:40 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60CBHe1Q011948;
	Mon, 12 Jan 2026 11:17:40 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedspen7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 11:17:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60CAJcIC025838;
	Mon, 12 Jan 2026 11:17:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm2kk5gbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 11:17:39 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60CBHbW521627358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 11:17:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97AAB2004B;
	Mon, 12 Jan 2026 11:17:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13F2B20040;
	Mon, 12 Jan 2026 11:17:36 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.87.146.254])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Jan 2026 11:17:35 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: wagi@kernel.org, martinus.gpy@gmail.com
Subject: [PATCH 1/2] nvme: avoid printing iopolicy in list-subsys output
Date: Mon, 12 Jan 2026 16:46:00 +0530
Message-ID: <20260112111731.1631091-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112111731.1631091-1-nilay@linux.ibm.com>
References: <20260112111731.1631091-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA5MCBTYWx0ZWRfX/ZP5PG0QRy1n
 hp/8vcffoQorBrRQQ6rLZvMukWzU3P9YnGPFcnEMSk2stZVHItHXklK9EDg9I/UqdhZ7yS9BIbW
 GI26o7z41kbYaMssz+FNKjtFjXMSEn2S3BFgdcxzQnDc5pd8zxWmnt49ZPqVSiiAHA+PSlAuk5m
 oghyJLXE/q8qRoRkJCugprOBAYLfGxcqbSonrk8FdKdusjLYOBknP4Jj7M788AFBIuPt8S6BywY
 j5XSIENxi3kmVVapcIugzhPR2WBcL1HXqLAgAhwwQyqKH9vlumcSpzlH8WtrVjj8+ISb21uelCY
 3DvGWnbfhvKMpG7X40NZ82/+0r/nQnxIr42qhZ7Jvv7awLdxzrLwsNruKl0ZcKNGjLDg0hGSAqV
 uPsP8nAXaHViZ7hFd14e7CeTKoL0kMpVygtjhxiNKpagtETVBIG8OiAnRLMg9Y8MRD+dpIdEA+q
 uqFqzAFK/wOWIAdbQ/w==
X-Proofpoint-GUID: u3ntIchD7ncZG-xLffudSuN9mniS9LKd
X-Authority-Analysis: v=2.4 cv=WLJyn3sR c=1 sm=1 tr=0 ts=6964d854 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=gSgC47sBT8opcuSRbfoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: VbJ3s0ULyk6gDkzzgohoLYx3rZTsVTi9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601120090
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260112_031744_877322_CC241CBF 
X-CRM114-Status: GOOD (  19.94  )
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

Since commit d0b4c6cf0006 (“nvme: extend show-topology command to add
support for multipath”), the subsystem header printed by both show-
topology and list-subsys includes the iopolicy field regardless of
whether the verbose flag is specified.

For show-topology, this behavior is intentional and useful. The command
now prints additional columns such as Nodes or queue-depth depending on
the configured I/O policy, and displaying the iopolicy value makes it
easier to correlate the output with the active policy configured for
the subsystem.

However, the same iopolicy field is also printed in the list-subsys
output, where it is not always relevant. This happens because both
commands share the common helper stdout_subsys_config() to print the
subsystem header.

This change fixes the inconsistency by always printing the iopolicy
field for show-topology, while suppressing it for list-subsys unless
the command is invoked with the verbose flag.

Fixes: d0b4c6cf0006 ("nvme: extend show-topology command to add support for multipath")
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 nvme-print-stdout.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/nvme-print-stdout.c b/nvme-print-stdout.c
index 7995052a3..9a4fe80d9 100644
--- a/nvme-print-stdout.c
+++ b/nvme-print-stdout.c
@@ -1135,7 +1135,7 @@ static void stdout_subsystem_ctrls(nvme_subsystem_t s)
 	}
 }
 
-static void stdout_subsys_config(nvme_subsystem_t s)
+static void stdout_subsys_config(nvme_subsystem_t s, bool show_iopolicy)
 {
 	int len = strlen(nvme_subsystem_get_name(s));
 
@@ -1143,8 +1143,9 @@ static void stdout_subsys_config(nvme_subsystem_t s)
 	       nvme_subsystem_get_nqn(s));
 	printf("%*s   hostnqn=%s\n", len, " ",
 	       nvme_host_get_hostnqn(nvme_subsystem_get_host(s)));
-	printf("%*s   iopolicy=%s\n", len, " ",
-		nvme_subsystem_get_iopolicy(s));
+	if (show_iopolicy)
+		printf("%*s   iopolicy=%s\n", len, " ",
+				nvme_subsystem_get_iopolicy(s));
 
 	if (stdout_print_ops.flags & VERBOSE) {
 		printf("%*s   model=%s\n", len, " ",
@@ -1179,7 +1180,8 @@ static void stdout_subsystem(struct nvme_global_ctx *ctx, bool show_ana)
 				printf("\n");
 			first = false;
 
-			stdout_subsys_config(s);
+			stdout_subsys_config(s,
+					stdout_print_ops.flags & VERBOSE);
 			printf("\\\n");
 
 			if (!show_ana || !stdout_subsystem_multipath(s))
@@ -6057,7 +6059,7 @@ static void stdout_topology_tabular(struct nvme_global_ctx *ctx)
 				printf("\n");
 			first = false;
 
-			stdout_subsys_config(s);
+			stdout_subsys_config(s, true);
 			printf("\n");
 
 			if (nvme_is_multipath(s))
@@ -6090,7 +6092,7 @@ static void stdout_simple_topology(struct nvme_global_ctx *ctx,
 				printf("\n");
 			first = false;
 
-			stdout_subsys_config(s);
+			stdout_subsys_config(s, true);
 			printf("\\\n");
 
 			if (nvme_is_multipath(s))
-- 
2.52.0


