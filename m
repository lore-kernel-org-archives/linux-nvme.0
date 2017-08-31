From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 31 Aug 2017 15:19:46 +0300
Subject: kernel tried to execute NX-protected page - exploit attempt?
 (uid: 0) and kernel BUG observed on 4.13.0-rc7
In-Reply-To: <625458077.3545624.1504152059580.JavaMail.zimbra@redhat.com>
References: <625458077.3545624.1504152059580.JavaMail.zimbra@redhat.com>
Message-ID: <9925ad05-5bfc-d645-5abd-5519cb8e2323@grimberg.me>

Hi Yi,

Can you share th host dmesg prior to the crash?

It looks like we get a timeout expiration on a request with
an already freed resources...

Did one of the controller resets in the loop fail by any chance?
