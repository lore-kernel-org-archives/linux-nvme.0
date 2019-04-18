From: aaron.ma@canonical.com (Aaron Ma)
Date: Thu, 18 Apr 2019 21:38:59 +0800
Subject: [PATCH] nvme: determine the number of IO queues
In-Reply-To: <fbc19fb1-5e2e-ff39-5295-f38195fb8d7c@gmail.com>
References: <1555510379-20199-1-git-send-email-aaron.ma@canonical.com>
 <a2f0a97e14b884dc1183db9cbdd6f4b520000ce3.camel@redhat.com>
 <096935354b16662eb481aeda1f48001ba489463c.camel@redhat.com>
 <e79703d5-3502-6519-a497-71b2b2a8768f@canonical.com>
 <99ab1942-9c38-695d-03dc-ea6eecb31217@gmail.com>
 <130f490e-e173-750d-994e-c00f7c0da080@canonical.com>
 <fbc19fb1-5e2e-ff39-5295-f38195fb8d7c@gmail.com>
Message-ID: <38bc8924-e553-70d7-c91d-b6c864379b43@canonical.com>



On 4/18/19 9:33 PM, Minwoo Im wrote:
> If the controller returns error for that command, how can we assure that
> the controller would support a single I/O queue ?

Make sense, I will keep *count = 0 in V2.

Thanks,
Aaron
