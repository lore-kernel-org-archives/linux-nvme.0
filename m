From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 29 Oct 2017 14:28:31 +0200
Subject: [PATCH 1/2] nvme_fc: fix localport resume using stale values
In-Reply-To: <20171027172805.13495-2-jsmart2021@gmail.com>
References: <20171027172805.13495-1-jsmart2021@gmail.com>
 <20171027172805.13495-2-jsmart2021@gmail.com>
Message-ID: <4640f307-5d61-838b-62d4-c8310ff4bd3b@grimberg.me>


> The localport resume was not updating the lldd ops structure. If the
> lldd is unloaded and reloaded, the ops pointers will differ.

Question, why is the lport kept around if the lldd unloaded?
