<html>
    <head>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">

        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    </head>
    <style>
        .invoice{
            color: black !important;
        }
    </style>
<body>
    <div id="invoice">
        <div class="invoice overflow-auto">
            <div style="min-width: 600px">
                <main>
                    <div class="row contacts">
                        <div>Dear Sir/Madam,</div><br>
                        {{-- <div>The {{$weeklyRecords->count()}} quotation were generated on {{date('d-m-Y',strtotime($startDate))}} - {{ date('d-m-Y',strtotime($endDate)) }}. </div><br>
                        </div> --}}
                        <div>The {{ $weeklyRecords ? $weeklyRecords->count() : 0 }} Job Card were generated on {{ date('d-m-Y', strtotime($startDate)) }} - {{ date('d-m-Y', strtotime($endDate)) }}.</div>

                    <br>
                    <table style='border: 1px solid black;border-collapse: collapse;width:80% !important;min-width:80% !important;' >
                        <thead>
                            <tr>
                                <th style='border: 1px solid black;border-collapse: collapse;text-align:left'>Sr.No.</th>
                                <th style='border: 1px solid black;border-collapse: collapse;text-align:left'>Job Card No.</th>
                                <th style='border: 1px solid black;border-collapse: collapse;text-align:left'>Job Card Title</th>
                                <th style='border: 1px solid black;border-collapse: collapse;text-align:left'>Size</th>
                                <th style='border: 1px solid black;border-collapse: collapse;text-align:left'>Generated By</th>
                                <th style='border: 1px solid black;border-collapse: collapse;text-align:left'>View </th>
                            </tr>
                        </thead>
                        <tbody>
                            @if ($weeklyRecords->count() > 0)
                                @foreach ($weeklyRecords as $jc)
                                @php
                                    $id = $jc->id;
                                    $jobtype=$jc->type;
                                    if($jobtype=="Thermal"){
                                        $pdf_url  = url("/thermalgeneratejobcardPDF/{$id}");
                                    }else if($jobtype=="Computer Stationary"){
                                        $pdf_url  = url("/csgeneratejobcardPDF/{$id}");
                                    }else if($jobtype=="Check"){
                                        $pdf_url  = url("/chequegeneratejobcardPDF/{$id}");
                                    }else{
                                        $pdf_url  = url("/generatejobcardPDF/{$id}");
                                    }
                                @endphp
                                <tr>
                                    <td style='border: 1px solid black;border-collapse: collapse'>{{ $loop->iteration }}</td>
                                    <td style='border: 1px solid black;border-collapse: collapse'>{{ $jc->job_card_no ?? '' }}</td>
                                    <td style='border: 1px solid black;border-collapse: collapse'>{{ $jc->job_card_title ?? '-'  }}</td>
                                    <td style='border: 1px solid black;border-collapse: collapse'>{{ $jc->width ?? '-' }} {{ $jc->getUnitJCWidth->description ?? '-' }} * {{ $jc->height ?? '-' }} {{ $jc->getUnitJCHeight->description ?? '-' }}</td>
                                    <td style='border: 1px solid black;border-collapse: collapse'>{{ $jc->getCreatedBy->fullname ?? ''}}</td>
                                    <td style='border: 1px solid black;border-collapse: collapse'>
                                        <a  title="PDF With Header & Footer" href="{{$pdf_url}}" target="_blank" class="menu-link flex-stack px-3">&#128206;</a>
                                    </td>
                                </tr>
                                @endforeach
                            @else
                                <tr>
                                        NO Record Found
                                </tr>
                            @endif
                        </tbody>
                    </table>
                    <br>
                    <div class="thanks">Thank you!</div>
                    <div class="notices">
                        <div class="notice">For Devharsh Infotech (P) Ltd.</div>
                    </div>
                </main>
            </div>
        </div>
    </div>
</body>
</html>
