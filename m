Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC03ACA0EF8
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Aug 2025 09:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gJmhiYrNFsKzCpA+1YNPVUUkRvh75zC/AMBNk7MjMXk=; b=Q9wiaU4d3OhmBnR0vwGm7eQKJh
	pYV3CVL0AjOUSC0nDRkKnP+4PWOF9DsE1WeIjISyu5lpdX9rkWdBjczNNK20ZE3BaybFWbP12XWRK
	/DIii/8WYIHboWGtVXL3/Pf2mircz0ppOQ7VHOeBSfQlRoukwpKqAeMunxXMh63qGWLVEIEC9DLBs
	79pSdtGU8g4weSdqUwTmQWkKQ9v93iLmXLVTOdSYhfzr+F4wYJX647tofGmUHsx7qkUlEOA5y2Ng4
	IlTY4EbD9jSYQJjGOMgwIgjAf4SzUdCJqJKJE0F3fI5cQYDvxBFgHI7EhoMLRtnQyxeiV8sC4/bU2
	dtWRkMYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoIdw-00000009xbs-0Erz;
	Tue, 19 Aug 2025 09:28:36 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoI8p-00000009rvf-3VrI
	for linux-nvme@lists.infradead.org;
	Tue, 19 Aug 2025 08:56:29 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ILoGBv009911;
	Tue, 19 Aug 2025 08:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gJmhiY
	rNFsKzCpA+1YNPVUUkRvh75zC/AMBNk7MjMXk=; b=OQ4EE8f50cwRUpVsYUm0h7
	T6yq7NakWmRZb65KUR16O9S+7Oi1Kgdphcp73KNFXnKdPurvLou0jKmqh8dLCOqa
	9ZHgS/Ol1xU3Y8vErugKMKgPe/bjE/4YjujwPZw8AoQBHzkxs4x3BnekbaWWCLbP
	cjXmkBD186no9LdCRoK4kHTeqyLdOIyQ6FHQL4SyEOCmGMFCNyvJbJAjS9wAHJzN
	CHgn8x3tsXNy+WTz4BdQZ6Ru95sDgsIeeIKg1TM9Kqo8TOolhlfI7ElNXGvvC89w
	OLEcbLPIs34tneif29o+0hnKOayv8uPEoN9iSpSbDlN0q7612C0Vy0NLnVRLjEPA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jge3wjh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 08:56:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57J5CfvE014720;
	Tue, 19 Aug 2025 08:56:23 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48k5tmsdc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 08:56:23 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57J8uFcU18612930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 08:56:15 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66C975805A;
	Tue, 19 Aug 2025 08:56:23 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 974ED5805D;
	Tue, 19 Aug 2025 08:56:21 +0000 (GMT)
Received: from [9.61.13.229] (unknown [9.61.13.229])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Aug 2025 08:56:21 +0000 (GMT)
Message-ID: <d7a65049-01e1-443d-9315-6ce8b9e9024f@linux.ibm.com>
Date: Tue, 19 Aug 2025 14:26:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 3/4] nvme: add common APIs for printing tabular format
 output
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, kbusch@kernel.org, gjoyce@ibm.com
References: <20250812125614.164445-1-nilay@linux.ibm.com>
 <20250812125614.164445-4-nilay@linux.ibm.com>
 <e99748f0-ed6e-496a-8f08-14f332f174ec@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <e99748f0-ed6e-496a-8f08-14f332f174ec@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FcM3xI+6 c=1 sm=1 tr=0 ts=68a43c38 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=mqMSCkNQAAAA:8
 a=bPUO5Xfwt1j4vTyZKtUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=M_KFMMzbnHq7hq2IOjCr:22
X-Proofpoint-GUID: pGcpWVDS31I0tvZ8lL5KcFmzMq99PmT7
X-Proofpoint-ORIG-GUID: pGcpWVDS31I0tvZ8lL5KcFmzMq99PmT7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAxMSBTYWx0ZWRfXzPsOjUrM91rD
 xDTY5+2Rs2CjwX4SDg8vg7oJYSbRa6Ga4SbZ0PxuSp1T1MYx2BbU5x+KWnW/u74vbDd+umHIqit
 8UhiEvL1np9MOJVDPNZ/IUc9Ckw+FWIqSE9S9CRuaVFhqI+i7gA7mLiptaK4j+uItzYfcECgRn1
 pSrf/QWIXWhFvvzwqKOeAfrRPaSTNNZ7PwoJ/zj1AQQIUL9xRJlEJt7nYt5a1O4tX5pqaaOujsZ
 uS3GqZDjWbAqOj5dskztC3UfyhM9CgSIfyMTHDrXyH2Bu5PO6YkNp1GfEpg+ZUij81Fc44I1BHz
 nH4fw2ok64AGBb4ugfpMOgXVI0yi5IBDhzlOjZW8NanZ1cuqU8qndQK9VilSdV1kE1nauCJcRS5
 DfeXs2B8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160011
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_015627_994175_A103E938 
X-CRM114-Status: GOOD (  31.35  )
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



On 8/18/25 12:57 PM, Hannes Reinecke wrote:
> On 8/12/25 14:56, Nilay Shroff wrote:
>> Some nvme-cli commands, such as nvme list and nvme list -v, support output
>> in tabular format. Currently, the table output is not well aligned because
>> column widths are fixed at print time, regardless of the length of the data
>> in each column. This often results in uneven and hard-to-read output.For
>> any new CLI command that requires tabular output, developers must manually
>> specify the column width and row value width, which is both error-prone and
>> inconsistent.
>>
>> This patch introduces a set of common table APIs that:
>> - Automatically calculate column widths based on the content
>> - Maintain proper alignment regardless of value length
>> - Simplify adding tabular output support to new and existing commands
>>
>> The new APIs are:
>> 1. table_init() — Allocate a table instance.
>> 2. table_add_columns() — Add column definitions (struct table_column),
>>     including name and alignment (LEFT, RIGHT, CENTERED).
>> 3. table_get_row_id() — Reserve a row index for inserting values.
>> 4. table_add_row() — Add a row to the table.
>> 5. table_print() — Print the table with auto-calculated widths.
>> 6. table_free() — Free resources allocated for the table.
>>
>> For adding values, the following setter APIs are provided, each
>> supporting alignment types (LEFT, RIGHT, or CENTERED):
>> - table_set_value_str()
>> - table_set_value_int()
>> - table_set_value_unsigned()
>> - table_set_value_long()
>> - table_set_value_unsigned_long()
>>
>> Usage steps:
>> 1. Call table_init() to create a table handle.
>> 2. Define an array of struct table_column specifying column names and
>>     alignment, then call table_add_columns().
>> 3. Obtain a row ID using table_get_row_id() and set values using the
>>     appropriate setter table APIs : table_set_value_*() function.
>> 4. Add the completed row using table_add_row().
>> 5. Repeat steps 3–4 for each additional row.
>> 5. Call table_print() to display the table.
>> 6. Call table_free() to release table resources.
>>
>> With these APIs, developers no longer need to pre-calculate column or row
>> widths. The output is consistently aligned and easy to read.
>>
>> Suggested-by: Daniel Wagner <dwagner@suse.de>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>   util/meson.build |   3 +-
>>   util/table.c     | 278 +++++++++++++++++++++++++++++++++++++++++++++++
>>   util/table.h     | 117 ++++++++++++++++++++
>>   3 files changed, 397 insertions(+), 1 deletion(-)
>>   create mode 100644 util/table.c
>>   create mode 100644 util/table.h
>>
> Sheesh. Can o'worms.
> 
> Displaying a table on an ASCII terminal is black magic (check
> manpage for ncurses ...), and I'm pretty certain that printing
> spaces for alignment is _not_ the way to go.
> If you really want to implement this then at the very least use
> tabs. Ideally check with the ncurses manpage how one can display
> a table with the correct escape characters.
> 
Thanks for the feedback. You're absolutely right that terminal alignment
can get tricky, and ncurses does provide a more feature-complete way to
handle interactive table layouts.

However, for this patch, the intent was much narrower — to make existing
nvme-cli tabular output (e.g., nvme list, nvme list -v and nvme show-topology)
more consistent and readable without requiring each command to manually set
column/row widths. The current implementation just calculates the max width
per column and pads with spaces, which works for the non-interactive, plain-text
output we typically expect from CLI tools (including when the output is
redirected to a file).

Using tabs was considered, but since most values (especially long PCI/target
addresses, UUIDs, or model names) don’t line up cleanly on tab stops, the result
was often misaligned depending on the terminal settings. Spaces gave us 
deterministic alignment across all environments.

That said, I completely agree ncurses (or similar) would be the right direction
if we wanted dynamic, interactive table display (resizable, scrollable, etc.). 
For nvme-cli, which is mostly non-interactive, my goal was to keep things simple
while improving readability.

That said, if you think it’s worth exploring a tabs-based approach instead, 
I can prototype that and compare the output side-by-side. Otherwise, perhaps
we can clarify in the commit message that this is meant for non-interactive,
plain ASCII output only. What do you think?

For your reference, I have printed below the output of nvme list -v 
command (before/after patch):

### Without this patch:

$ nvme list -v 
Subsystem        Subsystem-NQN                                                                                    Controllers
---------------- ------------------------------------------------------------------------------------------------ ----------------
nvme-subsys0     nqn.2018-01.com.wdc:guid:E8238FA6BF53-0001-001B444A495BF972                                      nvme0

Device           Cntlid SN                   MN                                       FR       TxPort Address        Slot   Subsystem    Namespaces      
---------------- ------ -------------------- ---------------------------------------- -------- ------ -------------- ------ ------------ ----------------
nvme0    8215   2136HZ464910         WDC PC SN730 SDBQNTY-512G-1001           11170101 pcie   0000:04:00.0          nvme-subsys0 nvme0n1

Device            Generic           NSID       Usage                      Format           Controllers     
----------------- ----------------- ---------- -------------------------- ---------------- ----------------
/dev/nvme0n1 /dev/ng0n1   0x1        512.11  GB / 512.11  GB    512   B +  0 B   nvme0


### With this patch applied and converting nvme list code to use the new table API:

$ nvme list -v 
Subsystem    Subsystem-NQN                                               Controllers 
------------ ----------------------------------------------------------- ----------- 
nvme-subsys0 nqn.2018-01.com.wdc:guid:E8238FA6BF53-0001-001B444A495BF972 nvme0       

Device Cntlid SN           MN                             FR       TxPort Address      Slot Subsystem    Namespaces 
------ ------ ------------ ------------------------------ -------- ------ ------------ ---- ------------ ---------- 
nvme0  8215   2136HZ464910 WDC PC SN730 SDBQNTY-512G-1001 11170101 pcie   0000:04:00.0      nvme-subsys0 nvme0n1    

Device       Generic    NSID USAGE                                             Format         Controllers 
------------ ---------- ---- ------------------------------------------------- -------------- ----------- 
/dev/nvme0n1 /dev/ng0n1  0x1 512.11 GB / 512.11 GB ( 476.94 GiB /  476.94 GiB) 512   B +  0 B nvme0       

Thanks,
--Nilay

