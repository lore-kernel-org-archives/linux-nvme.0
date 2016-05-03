From: shhuiw@foxmail.com (=?ISO-8859-1?B?V2FuZyBTaGVuZy1IdWk=?=)
Date: Tue, 3 May 2016 14:33:32 +0800
Subject: May nvme_get_ns_from_disk introduce deadlock?
Message-ID: <tencent_0E8E6EA15D543CDF17012F42@qq.com>

Hi,

I'm reading the code, and found that nvme_get_ns_from_disk *may* 
introduce deadlock by invoking nvme_free_ns in core.c (nested
spin_lock(&dev_list_lock) ). 
But I can't figure out which condition can lead to deadlock.

Will someone help to explain the code that how can it escape from deadlock?

Thanks,
Wang Sheng-Hui
