From: pawelx.cybulski@intel.com (Cybulski, PawelX)
Date: Thu, 18 Jan 2018 14:24:12 +0000
Subject: Support needed with setting up multipath on NVMeoF
Message-ID: <CDAF3D5FC44D984DBB5AC42F738B4BA2589895F5@IRSMSX107.ger.corp.intel.com>

Hi,

What I want to achieve is:
-	Two NVMe targets pointing to the same NVMe 
-	Targets mounted twice on initiator via different paths (different ports in RDMA NIC)
-	Setup nvmeof multipath on initiator side
-	Run fio tests, bring down one interface and check if it will go through another
-	Run fio tests, via both interfaces at the same time

So far I have:
-	Two machines with kernel 4.15.0-rc8 compiled with CONFIG_NVME_MULTIPATH=y
-	Two targets started on server each pointing to the same NVMe (each using different network port and different ip)
-	Targets mounted on initiator side

Nvme list-subsys is displaying
nvme-subsys0 - NQN=nvme-subsystem-TEST
\
+- nvme0 rdma traddr=100.0.0.90 trsvcid=1055
nvme-subsys1 - NQN=nvme-subsystem-TEST2
\
+- nvme1 rdma traddr=100.0.50.90 trsvcid=1055

I am using latest nvme-cli:
v0.2-612-g8466996

Tried to look through documentation in nvme-cli, and I found only:
"       -m, --nmic
           Namespace multipath and sharing capabilities.

EXAMPLES
       No examples provided yet."

In ./nvme-create-ns.1

Could you point me to documentation where I could find setup steps for nvme multipath (different options, fail over, round robin), or if there isn't any could you provide me with some steps to follow.



Best Regards,
Pawe? Cybulski?


--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.
