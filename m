From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 11 Feb 2018 13:17:56 +0200
Subject: [PATCH 3/9] nvme: change namespaces_mutext to namespaces_rwsem
In-Reply-To: <1518341920-1060-4-git-send-email-jianchao.w.wang@oracle.com>
References: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
 <1518341920-1060-4-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <4170b29e-693c-9c61-1b3b-716af09e44d0@grimberg.me>

> namespaces_mutext is used to synchronize the operations on ctrl
> namespaces list. Most of the time, it is a read operation. It is
> better to change it from mutex to rwsem.
> 
> On the other hand, the namespaces mutex could introduce circular
> dependency easily.

On the other hand of what?

Also, can you give an example of such?
