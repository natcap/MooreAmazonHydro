import logging
import sys
import os
import glob

import natcap.invest.sdr.sdr
import natcap.invest.utils

LOGGER = logging.getLogger(__name__)
root_logger = logging.getLogger()

handler = logging.StreamHandler(sys.stdout)
formatter = logging.Formatter(
    fmt=natcap.invest.utils.LOG_FMT,
    datefmt='%m/%d/%Y %H:%M:%S ')
handler.setFormatter(formatter)
logging.basicConfig(level=logging.INFO, handlers=[handler])

args = {
    'biophysical_table_path': 'C:/Users/jgldstn/Documents/MooreAmazonHydro/SDR_Biophysical_Chaglla_LUscenarios_NO_terracing.csv',
    'dem_path': 'G:/Shared drives/Moore Amazon Hydro/2_models/SDR_SWY_data_inputs/projected/HydroSHEDS_CON_Chaglla_UTM18S.tif',
    'drainage_path': '',
    'erodibility_path': 'G:/Shared drives/Moore Amazon Hydro/2_models/SDR_SWY_data_inputs/projected/erodibility_ISRIC_30arcseconds.tif',
    'ic_0_param': '0.1',
    'k_param': '3.0',
    'l_max': '122',
    'lulc_path': 'C:/Users/jgldstn/Documents/MooreAmazonHydro/Land Use Scenarios/LUCC_Escenario3.tif',
    'n_workers': '-1',
    'sdr_max': '1.0',
    'threshold_flow_accumulation': '1000',
    'watersheds_path': 'G:/Shared drives/Moore Amazon Hydro/2_models/SDR_SWY_data_inputs/projected/Chaglla_dam_watershed.shp',
    'workspace_dir': 'C:/Users/jgldstn/Documents/MooreAmazonHydro/Land Use Scenarios/SDRresults/',
}

erosivity_dir = r'G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/erosivityOutputs/'

if __name__ == '__main__':
    for erosivity_file in glob.glob(os.path.join(erosivity_dir, 'R*.tif')):
        args['erosivity_path'] = erosivity_file
        args['results_suffix'] = 'Escenario3_' + os.path.splitext(os.path.basename(erosivity_file))[0]
        natcap.invest.sdr.sdr.execute(args)

args = {
    'biophysical_table_path': 'C:/Users/jgldstn/Documents/MooreAmazonHydro/SDR_Biophysical_Chaglla_LUscenarios_NO_terracing.csv',
    'dem_path': 'G:/Shared drives/Moore Amazon Hydro/2_models/SDR_SWY_data_inputs/projected/HydroSHEDS_CON_Chaglla_UTM18S.tif',
    'drainage_path': '',
    'erodibility_path': 'G:/Shared drives/Moore Amazon Hydro/2_models/SDR_SWY_data_inputs/projected/erodibility_ISRIC_30arcseconds.tif',
    'ic_0_param': '0.1',
    'k_param': '3.0',
    'l_max': '122',
    'lulc_path': 'C:/Users/jgldstn/Documents/MooreAmazonHydro/Land Use Scenarios/LUCC_Escenario4.tif',
    'n_workers': '-1',
    'sdr_max': '1.0',
    'threshold_flow_accumulation': '1000',
    'watersheds_path': 'G:/Shared drives/Moore Amazon Hydro/2_models/SDR_SWY_data_inputs/projected/Chaglla_dam_watershed.shp',
    'workspace_dir': 'C:/Users/jgldstn/Documents/MooreAmazonHydro/Land Use Scenarios/SDRresults/',
}

erosivity_dir = r'G:/Shared drives/Moore Amazon Hydro/1_base_data/Climate data/Downscaled NC data/ssp585/pr/erosivityOutputs/'

if __name__ == '__main__':
    for erosivity_file in glob.glob(os.path.join(erosivity_dir, 'R*.tif')):
        args['erosivity_path'] = erosivity_file
        args['results_suffix'] = 'Escenario4_' + os.path.splitext(os.path.basename(erosivity_file))[0]
        natcap.invest.sdr.sdr.execute(args)
