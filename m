From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 20 Apr 2017 14:37:56 +0300
Subject: [PATCH v3] nvme-rdma: support devices with queue size < 32
In-Reply-To: <1677617891.385461828.1492681414720.JavaMail.zimbra@kalray.eu>
References: <1519881025.363156294.1491837154312.JavaMail.zimbra@kalray.eu>
 <1491838338.4199.5.camel@sandisk.com>
 <1807354347.364485979.1491900728245.JavaMail.zimbra@kalray.eu>
 <1491923426.2654.1.camel@sandisk.com>
 <1677617891.385461828.1492681414720.JavaMail.zimbra@kalray.eu>
Message-ID: <391faec7-924d-7af2-eb1b-b3106bd4193c@grimberg.me>

Looks good,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>

BTW, did you test with deeper queue depths (say 512)?
