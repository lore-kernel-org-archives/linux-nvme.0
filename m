Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57946C27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 15:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=I/Z6N+8GhYKAY2oDMx40QxjDLD0DkKbXD3UysbN8DvI=; b=Djs0dHupjPJ2wK7/p4XpSoWzfs
	EFYhrFHCBLLoqBq5WjTEldbEHrbX2VGh/BmPrIUgRdGat9X8m6blSeOyT88N5AmZlKOAC9AKsn8Ix
	P7gu/ObH4mqxqLKch8+tnb+MqtKyW8xTxbWhbNsymnQCSlWFW8YhX+7t1y0nv7mKJhuuN+srfN1o4
	P2IyE1hqitf+9uwoWFj+qWWsJ3iap8y1hj4EpRKexewxGt/yFK8EjT7n5VYpbx0LLHpAkLEEwk5Pn
	rjK6rUftqftAJdknOcjsbIqNIKj1pYH9/E/YYsb7sXV8xg+ioY+83LAPNz8xQedGRhYHR5+jb2cqp
	0S5Cl0aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHQGb-0000000DFIE-2d8b;
	Wed, 12 Jun 2024 15:52:05 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHQGY-0000000DFHL-3E2f
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jun 2024 15:52:04 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 45CFEv7F030677
	for <linux-nvme@lists.infradead.org>; Wed, 12 Jun 2024 08:52:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=s2048-2021-q4;
 bh=I/Z6N+8GhYKAY2oDMx40QxjDLD0DkKbXD3UysbN8DvI=;
 b=F59ldffTNBenHKBhWMmTrYlfiDKpxNy/YcsE8FHZ5mJ0eHqKohUX/2S2n7gIHsLnH/XY
 v+tu7vrRbT7Aqa37QzcPu1YSLrCxyb3ZdPtvtEzhLkmwhlDiInTeL9MfAXXJSUFgOIyL
 M5pChy1VRE+yWbwWshmtr1yPfFi0tF/Bzw92PCu6zleAbq8FVyqHyv7gAT+FUiRFBjmn
 JMv9Px6Nhvy9x4Gy7Ir+7nq/Cv+pvkffzWKS8R0FuxVCwXO8+6rpy8H4Go6HF8TAz4/X
 hKiODwIj5mLIuvXGYsiCCPLYqM2HLjQHL+13lWsi0Jc+Ttwu4JPnvof7m7Ibc2hNE6hS Vw== 
Received: from mail.thefacebook.com ([163.114.134.6])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yqd9ggnu3-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 12 Jun 2024 08:52:00 -0700
Received: from twshared15118.35.frc1.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 12 Jun 2024 15:51:58 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id DCB8BF5EA644; Wed, 12 Jun 2024 08:51:47 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <paulmck@kernel.org>,
        <davidgow@google.com>, <akpm@linux-foundation.org>,
        <venkat88@linux.vnet.ibm.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/2] list: introduce a new cutting helper
Date: Wed, 12 Jun 2024 08:51:34 -0700
Message-ID: <20240612155135.3060667-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: QcXF9hlZqBJWB27OrwgwKy46aaKCZPLU
X-Proofpoint-ORIG-GUID: QcXF9hlZqBJWB27OrwgwKy46aaKCZPLU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_08,2024-06-12_02,2024-05-17_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_085203_060328_0DD38A55 
X-CRM114-Status: GOOD (  16.67  )
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

From: Keith Busch <kbusch@kernel.org>

Provide a helper to remove elements from a list to the end, and place
those elements in a new list.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/list.h | 20 ++++++++++++++++++++
 lib/list-test.c      | 29 +++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/list.h b/include/linux/list.h
index 5f4b0a39cf46a..f22850e854820 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -520,6 +520,26 @@ static inline void list_cut_before(struct list_head =
*list,
 	entry->prev =3D head;
 }
=20
+/**
+ * list_cut - cut a list into two from the entry
+ * @list: a new list to add all removed entries
+ * @head: a list with entries
+ * @entry: an entry within head, could be the head itself
+ *
+ * This helper removes elements from @head starting at @entry until the =
end,
+ * and appends them to @lists.
+ */
+static inline void list_cut(struct list_head *list,
+		struct list_head *head, struct list_head *entry)
+{
+	list->next =3D entry;
+	list->prev =3D head->prev;
+	head->prev =3D entry->prev;
+	entry->prev->next =3D head;
+	entry->prev =3D list;
+	list->prev->next =3D list;
+}
+
 static inline void __list_splice(const struct list_head *list,
 				 struct list_head *prev,
 				 struct list_head *next)
diff --git a/lib/list-test.c b/lib/list-test.c
index 0cc27de9cec88..1507f46cf1ade 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -382,6 +382,34 @@ static void list_test_list_is_singular(struct kunit =
*test)
 	KUNIT_EXPECT_FALSE(test, list_is_singular(&list));
 }
=20
+static void list_test_list_cut(struct kunit *test)
+{
+	struct list_head entries[3], *cur;
+	LIST_HEAD(list1);
+	LIST_HEAD(list2);
+	int i =3D 0;
+
+	list_add_tail(&entries[0], &list1);
+	list_add_tail(&entries[1], &list1);
+	list_add_tail(&entries[2], &list1);
+
+	/* before: [list1] -> entries[0] -> entries[1] -> entries[2] */
+	list_cut(&list2, &list1, &entries[1]);
+	/* after: [list1] -> entries[0], [list2] -> entries[1] -> entries[2] */
+
+	list_for_each(cur, &list1) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 1);
+
+	list_for_each(cur, &list2) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		i++;
+	}
+}
+
 static void list_test_list_cut_position(struct kunit *test)
 {
 	struct list_head entries[3], *cur;
@@ -780,6 +808,7 @@ static struct kunit_case list_test_cases[] =3D {
 	KUNIT_CASE(list_test_list_is_singular),
 	KUNIT_CASE(list_test_list_cut_position),
 	KUNIT_CASE(list_test_list_cut_before),
+	KUNIT_CASE(list_test_list_cut),
 	KUNIT_CASE(list_test_list_splice),
 	KUNIT_CASE(list_test_list_splice_tail),
 	KUNIT_CASE(list_test_list_splice_init),
--=20
2.43.0


